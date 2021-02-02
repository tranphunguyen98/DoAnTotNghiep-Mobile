import 'package:dio/dio.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/remote/remote_user_service.dart';
import 'package:totodo/data/repositories/remote_user_data_source.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final RemoteUserService _userService;
  RemoteUserDataSourceImpl(this._userService);
  @override
  Future<bool> changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<bool> resetPassword(String email, String password) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signIn(String email, String password) async {
    try {
      print("signUp! $email $password");
      final userResponse = await _userService.signIn(email, password);
      print("No error!");
      print(userResponse.message.toString());
      return userResponse.user;
    } on DioError catch (e) {
      print("Error: $e");

      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp(String email, String password) async {
    try {
      print("signUp! $email $password");
      final userResponse = await _userService.signUp(email, password);
      print("No error!");
      print(userResponse.message.toString());
      return true;
    } on DioError catch (e) {
      print("Error: $e");

      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }
}
