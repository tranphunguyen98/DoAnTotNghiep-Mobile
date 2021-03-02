import 'package:totodo/data/entity/user.dart';

abstract class IUserRepository {
  Future<User> signIn(String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<bool> signUp(String displayName, String email, String password);
  Future<bool> changePassword(String oldPassword, String newPassword);
  Future<bool> resetPassword(String email, String password);
  Future<bool> isSignedIn();
  Future<User> getUser();
  Future<bool> saveUser(User user);
  Future<bool> signOut();
}
