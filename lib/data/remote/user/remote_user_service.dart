import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/response/message_response.dart';
import 'package:totodo/data/response/user_response.dart';

part 'remote_user_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3006/")
abstract class RemoteUserService {
  factory RemoteUserService(Dio dio, {String baseUrl}) = _RemoteUserService;

  @POST("/users/register")
  Future<UserResponse> signUp(@Field() String email, @Field() String password);

  @POST("/users/login")
  Future<UserResponse> signIn(@Field() String email, @Field() String password);

  @POST("/users/reset_password")
  Future<MessageResponse> resetPassword(
      @Field() String email, @Field() String password);

  @POST("/users/change_password")
  Future<MessageResponse> changePassword(
      @Field() String oldPassword, @Field() String newPassword);
}