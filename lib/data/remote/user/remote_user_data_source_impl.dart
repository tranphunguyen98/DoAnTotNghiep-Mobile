import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totodo/data/data_source/user/remote_user_data_source.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/remote/user/remote_user_service.dart';
import 'package:totodo/di/injection.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RemoteUserService _userService;

  RemoteUserDataSourceImpl(this._userService);

  @override
  Future<bool> changePassword(
      String authorization, String oldPassword, String newPassword) async {
    try {
      // print("signUp! $oldPassword $newPassword");
      final messageResponse = await _userService.changePassword(
          authorization, oldPassword, newPassword);
      // print("No error!");
      // print(messageResponse.message.toString());
      if (messageResponse.succeeded) {
        return true;
      }
      throw Exception("Change Password Failed!");
    } on DioError catch (e) {
      // print("Error: $e");

      // print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> resetPassword(
      String email, String optCode, String password) async {
    try {
      final messageResponse =
          await _userService.resetPassword(email, optCode, password);
      // print(messageResponse.message.toString());
      if (messageResponse.succeeded) {
        return true;
      }
      throw Exception("Reset Password Failed!");
    } on DioError catch (e) {
      // print("Error: ${e ?? "Error Dio"}");
      throw Exception(e.response?.data['message'] ?? "Error Dio");
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final userResponse = await _userService.signIn(email, password);
      // print("userResponse: $userResponse}");
      return userResponse.user;
    } on DioError catch (e) {
      // print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
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
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelledByUser');
        throw Exception('Cancelled By User');
        break;
      case FacebookLoginStatus.error:
        print('error: ${result.errorMessage}');
        throw Exception(result.errorMessage);
        break;
      default:
        throw Exception("Error login with Facebook");
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      print("User: 0");

      _firebaseAuth.signOut();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print("User: 1 ${googleUser.displayName}");
      return User(
          type: User.kTypeGoogle,
          email: googleUser.email,
          name: googleUser.displayName,
          avatar: googleUser.photoUrl);

      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;
      // final AuthCredential credential = GoogleAuthProvider.getCredential(
      //     idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      // print("User: 2");
      //
      // await _firebaseAuth.signInWithCredential(credential);
      // final user = await _firebaseAuth.currentUser();
      // print("User: $user");
      // return User(
      //     type: User.kTypeGoogle,
      //     email: user.email,
      //     name: user.displayName,
      //     avatar: user.photoUrl);
    } catch (e, trace) {
      print("trace: $trace");
      rethrow;
    }
  }

  @override
  Future<bool> signUp(String displayName, String email, String password) async {
    try {
      final messageResponse =
          await _userService.signUp(displayName, email, password);
      print(messageResponse);
      print(messageResponse.message.toString());
      if (messageResponse.succeeded) {
        return true;
      }
      throw Exception(messageResponse.message ?? "Error Dio");
    } on DioError catch (e, stackTrace) {
      print(stackTrace);
      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> sendOTPResetPassword(String email) async {
    try {
      final messageResponse = await _userService.sendOTPResetPassword(email);
      print(messageResponse);
      print(messageResponse.message.toString());
      if (messageResponse.succeeded) {
        return true;
      }
      throw Exception(messageResponse.message ?? "Error Dio");
    } on DioError catch (e, stackTrace) {
      print(stackTrace);
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
