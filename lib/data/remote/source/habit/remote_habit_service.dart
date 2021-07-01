import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/remote/response/habit_diary_response.dart';
import 'package:totodo/data/remote/response/habit_list_response.dart';
import 'package:totodo/data/remote/response/habit_response.dart';
import 'package:totodo/data/remote/response/message_response_register.dart';
import 'package:totodo/utils/util.dart';

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

  @POST("/habits")
  Future<HabitResponse> addHabit(
    @Header("authorization") String authorization,
    @Body() Map<String, dynamic> body,
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
