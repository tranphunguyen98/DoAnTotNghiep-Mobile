import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/data_source/user/remote_user_data_source.dart';
import 'package:totodo/data/entity/user.dart';

class UserRepositoryImpl implements IUserRepository {
  final RemoteUserDataSource _remoteUserDataSource;
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._remoteUserDataSource, this._localUserDataSource);

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) =>
      _remoteUserDataSource.changePassword(oldPassword, newPassword);

  @override
  Future<bool> resetPassword(String email, String password) =>
      _remoteUserDataSource.resetPassword(email, password);

  @override
  Future<User> signIn(String email, String password) =>
      _remoteUserDataSource.signIn(email, password);

  @override
  Future<User> signInWithFacebook() =>
      _remoteUserDataSource.signInWithFacebook();

  @override
  Future<User> signInWithGoogle() => _remoteUserDataSource.signInWithGoogle();

  @override
  Future<bool> signUp(String displayName, String email, String password) =>
      _remoteUserDataSource.signUp(displayName, email, password);

  @override
  Future<User> getUser() => _localUserDataSource.getUser();

  @override
  Future<bool> isSignedIn() => _localUserDataSource.isSignedIn();

  @override
  Future<bool> saveUser(User user) => _localUserDataSource.saveUser(user);

  @override
  Future<bool> signOut() async {
    await _localUserDataSource.signOut();
    await _remoteUserDataSource.signOut();
    return true;
  }
}
