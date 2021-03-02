import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/response/message_response.dart';
import 'package:totodo/data/response/message_response_register.dart';
import 'package:totodo/data/response/user_response.dart';

part 'remote_user_service.g.dart';

//10.0.2.2
@RestApi(baseUrl: "http://192.168.1.7:3006/")
abstract class RemoteUserService {
  factory RemoteUserService(Dio dio, {String baseUrl}) = _RemoteUserService;

  @POST("/users/register")
  Future<MessageResponseRegister> signUp(@Field() String displayName,
      @Field() String email, @Field() String password);

  @POST("/users/login")
  Future<UserResponse> signIn(@Field() String email, @Field() String password);

  @POST("/users/reset-password")
  Future<MessageResponseRegister> resetPassword(@Field() String email,
      @Field() String otpCode, @Field() String newPassword);

  @POST("/users/reset-password/request")
  Future<MessageResponseRegister> sendOTPResetPassword(@Field() String email);

  @POST("/users/change-password")
  Future<MessageResponseRegister> changePassword(
      @Header("authorization") String authorization,
      @Field() String old_password,
      @Field() String password);
}
