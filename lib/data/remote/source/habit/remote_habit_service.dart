import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/remote/response/diary_response.dart';
import 'package:totodo/data/remote/response/habit_diary_response.dart';
import 'package:totodo/data/remote/response/habit_list_response.dart';
import 'package:totodo/data/remote/response/habit_response.dart';
import 'package:totodo/data/remote/response/message_response.dart';
import 'package:totodo/data/remote/response/message_response_register.dart';

part 'remote_habit_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.18:3006/")
abstract class RemoteHabitService {
  factory RemoteHabitService(Dio dio, {String baseUrl}) = _RemoteHabitService;

  @GET("/habits/by-user")
  Future<HabitListResponse> getHabits(
    @Header("authorization") String authorization,
  );

  @GET("habits/{habitId}")
  Future<HabitResponse> getHabitDetail(
      @Header("authorization") String authorization, @Path() String habitId);

  @PATCH("habits/{habitId}")
  Future<HabitResponse> updateHabit(
    @Header("authorization") String authorization,
    @Path() String habitId,
    @Body() Map<String, dynamic> body,
  );

  @POST("/habits")
  Future<HabitResponse> addHabit(
    @Header("authorization") String authorization,
    @Body() Map<String, dynamic> body,
  );

  @MultiPart()
  @POST("/habits/{habitId}/add-diary")
  Future<MessageResponse> addDiary(
    @Header("authorization") String authorization,
    @Path() String habitId,
    @Part(name: 'text') String text,
    @Part(name: 'feeling') int feeling,
    @Part(name: 'time') String time,
    // @Part(name: 'time') String time,
    // @Body() Map<String, dynamic> body,
  );

  @DELETE("/habits/{habitId}")
  Future<MessageResponseRegister> deleteHabit(
    @Header("authorization") String authorization,
    @Path() String habitId,
  );

  @GET("/habits/{habitId}/diaries")
  Future<DiaryListResponse> getDiaryByHabitId(
      @Header("authorization") String authorization, @Path() String habitId);
}
