import 'package:dio/dio.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/data/remote/remote_user_service.dart';
import 'package:totodo/data/repositories/remote_user_data_source.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final RemoteUserService _userService;
  RemoteUserDataSourceImpl(this._userService);
  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      print("signUp! $oldPassword $newPassword");
      final messageResponse =
          await _userService.changePassword(oldPassword, newPassword);
      print("No error!");
      print(messageResponse.msg.toString());
      if (messageResponse.isSuccess) {
        return true;
      }
      throw Exception("Change Password Failed!");
    } on DioError catch (e) {
      print("Error: $e");

      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> resetPassword(String email, String password) async {
    try {
      print("signUp! $email $password");
      final messageResponse = await _userService.resetPassword(email, password);
      print("No error!");
      print(messageResponse.msg.toString());
      if (messageResponse.isSuccess) {
        return true;
      }
      throw Exception("Reset Failed!");
    } on DioError catch (e) {
      print("Error: $e");

      print("Error: ${e.response.data["message"]}");
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
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
