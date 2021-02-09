import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totodo/data/data_source/remote_user_data_source.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/remote/remote_user_service.dart';

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
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
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
