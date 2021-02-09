import 'package:totodo/data/entity/user.dart';

abstract class RemoteUserDataSource {
  Future<User> signIn(String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<bool> signUp(String email, String password);
  Future<bool> changePassword(String oldPassword, String newPassword);
  Future<bool> resetPassword(String email, String password);
  Future<void> signOut();
}
