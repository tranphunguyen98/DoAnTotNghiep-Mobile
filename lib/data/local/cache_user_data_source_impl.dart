import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/local/local_user_service.dart';
import 'package:totodo/data/repositories/local_user_data_source.dart';

class LocalUserDataSourceImplement implements LocalUserDataSource {
  final LocalUserService _userService;

  LocalUserDataSourceImplement(this._userService);

  @override
  Future<User> getUser() => _userService.getUser();

  @override
  Future<bool> isSignedIn() => _userService.isSignedIn();

  @override
  Future<bool> saveUser(User user) => _userService.saveUser(user);
}
