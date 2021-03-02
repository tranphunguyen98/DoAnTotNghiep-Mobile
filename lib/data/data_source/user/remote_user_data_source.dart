import 'package:totodo/data/entity/user.dart';

abstract class RemoteUserDataSource {
  Future<User> signIn(String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<bool> signUp(String displayName, String email, String password);
  Future<bool> changePassword(String oldPassword, String newPassword);
  Future<bool> resetPassword(String email, String otpCode, String password);
  Future<bool> sendOTPResetPassword(String email);
  Future<void> signOut();
}
