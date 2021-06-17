import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/model/user.dart';

import 'local_user_service.dart';

class LocalUserDataSourceImplement implements LocalUserDataSource {
  final LocalUserService _userService;

  LocalUserDataSourceImplement(this._userService);

  @override
  Future<User> getUser() => _userService.getUser();

  @override
  Future<bool> isSignedIn() => _userService.isSignedIn();

  @override
  Future<bool> saveUser(User user) => _userService.saveUser(user);

  @override
  Future<bool> signOut() => _userService.clearUser();
}
