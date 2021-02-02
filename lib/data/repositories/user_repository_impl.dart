import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/repositories/local_user_data_source.dart';
import 'package:totodo/data/repositories/remote_user_data_source.dart';

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
  Future<bool> signInWithFacebook() =>
      _remoteUserDataSource.signInWithFacebook();

  @override
  Future<bool> signInWithGoogle() => _remoteUserDataSource.signInWithGoogle();

  @override
  Future<bool> signUp(String email, String password) =>
      _remoteUserDataSource.signUp(email, password);

  @override
  Future<User> getUser() => _localUserDataSource.getUser();

  @override
  Future<bool> isSignedIn() => _localUserDataSource.isSignedIn();

  @override
  Future<bool> saveUser(User user) => _localUserDataSource.saveUser(user);

  @override
  Future<bool> signOut() async {
    return true;
    //TODO Sign Out
  }
}
