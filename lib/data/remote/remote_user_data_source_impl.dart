import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totodo/data/data_source/remote_user_data_source.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/remote/remote_user_service.dart';
import 'package:totodo/di/injection.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RemoteUserService _userService;

  RemoteUserDataSourceImpl(this._userService);

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      print("signUp! $oldPassword $newPassword");
      final messageResponse =
          await _userService.changePassword(oldPassword, newPassword);
      print("No error!");
      print(messageResponse.msg.toString());
      if (messageResponse.isSuccess) {
        return true;
      }
      throw Exception("Change Password Failed!");
    } on DioError catch (e) {
      print("Error: $e");

      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> resetPassword(String email, String password) async {
    try {
      final messageResponse = await _userService.resetPassword(email, password);
      print(messageResponse.msg.toString());
      if (messageResponse.isSuccess) {
        return true;
      }
      throw Exception("Reset Password Failed!");
    } on DioError catch (e) {
      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final userResponse = await _userService.signIn(email, password);
      return userResponse.user;
    } on DioError catch (e) {
      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          print(result.accessToken.token);
          final graphResponse = await getIt<Dio>().get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}');

          final jsonResponse = jsonDecode(graphResponse.data as String);

          return User(
            id: jsonResponse['id'] as String,
            avatar: jsonResponse['picture']['data']['url'] as String,
            name: jsonResponse['name'] as String,
            email: jsonResponse['email'] as String,
            type: User.kTypeFacebook,
          );
        } catch (e, stacktrace) {
          print(stacktrace);
        }
        // print(graphResponse.data['email']);
        // print(graphResponse.data['picture']);

        //_sendTokenToServer(result.accessToken.token);
        //_showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        //_showCancelledMessage();
        print('cancelledByUser');
        break;
      case FacebookLoginStatus.error:
        print('error: ${result.errorMessage}');
        throw Exception(result.errorMessage);
        //_showErrorOnUI(result.errorMessage);
        break;
    }
    //
    // try {
    //   // by default the login method has the next permissions ['email','public_profile']
    //   AccessToken accessToken = await FacebookAuth.instance.login();
    //   print(accessToken.toJson());
    //   // get the user data
    //   final userData = await FacebookAuth.instance.getUserData();
    //   print("User data $userData");
    // } on FacebookAuthException catch (e) {
    //   switch (e.errorCode) {
    //     case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
    //       print("You have a previous login operation in progress");
    //       break;
    //     case FacebookAuthErrorCode.CANCELLED:
    //       print("login cancelled");
    //       break;
    //     case FacebookAuthErrorCode.FAILED:
    //       print("login failed");
    //       print("message FB: ${e.message}");
    //       break;
    //   }
    // }
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await _firebaseAuth.signInWithCredential(credential);
    final user = await _firebaseAuth.currentUser();
    return User(
        email: user.email, name: user.displayName, avatar: user.photoUrl);
  }

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      final userResponse = await _userService.signUp(email, password);
      print(userResponse.message.toString());
      return true;
    } on DioError catch (e) {
      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
