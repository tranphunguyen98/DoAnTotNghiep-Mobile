import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../response/message_response_register.dart';
import '../../response/user_response.dart';

part 'remote_user_service.g.dart';

//10.0.2.2
@RestApi(baseUrl: "http://192.168.1.183:3006/")
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
      @Field() String oldPassword,
      @Field() String password);
}
