import 'package:totodo/data/entity/user.dart';

abstract class LocalUserDataSource {
  Future<bool> isSignedIn();
  Future<User> getUser();
  Future<bool> saveUser(User user);
  Future<bool> signOut();
}
