import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/data_source/user/remote_user_data_source.dart';
import 'package:totodo/data/model/user.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';
import 'package:totodo/utils/util.dart';

class UserRepositoryImpl implements IUserRepository {
  final RemoteUserDataSource _remoteUserDataSource;
  final LocalUserDataSource _localUserDataSource;

  UserRepositoryImpl(this._remoteUserDataSource, this._localUserDataSource);

  @override
  Future<bool> changePassword(
          String authorization, String oldPassword, String newPassword) =>
      _remoteUserDataSource.changePassword(
          authorization, oldPassword, newPassword);

  @override
  Future<bool> resetPassword(String email, String otpCode, String password) =>
      _remoteUserDataSource.resetPassword(email, otpCode, password);

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

  @override
  Future<bool> sendOTPResetPassword(String email) {
    return _remoteUserDataSource.sendOTPResetPassword(email);
  }

  @override
  Future<User> renewUser() async {
    final oldUser = await _localUserDataSource.getUser();
    final newUser = await _remoteUserDataSource.renewUser(oldUser);
    await _localUserDataSource.saveUser(newUser);
    log('newUser', newUser);
    return newUser;
  }
}