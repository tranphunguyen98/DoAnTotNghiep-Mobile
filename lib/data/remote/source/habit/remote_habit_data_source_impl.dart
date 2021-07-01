import 'package:dio/dio.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/remote/source/habit/remote_habit_service.dart';
import 'package:totodo/utils/util.dart';

class RemoteHabitDataSourceImpl implements RemoteHabitDataSource {
  final RemoteHabitService _habitService;

  RemoteHabitDataSourceImpl(this._habitService);

  @override
  Future<bool> addHabit(String authorization, Habit habit) async {
    final response =
        await _habitService.addHabit(authorization, habit.toJson());
    if (response.succeeded) {
      return true;
    }
    return false;
  }

  @override
  Future<void> clearOffline() {
    // TODO: implement clearOffline
    throw UnimplementedError();
  }

  @override
  Future<List<Habit>> getAllHabit(String authorization) async {
    try {
      final habitListResponse = await _habitService.getHabits(authorization);
      if (habitListResponse.succeeded) {
        return habitListResponse.habits;
      }
      throw Exception(habitListResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('Unhandled', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<Habit> getDetailHabit(String authorization, String id) async {
    try {
      final habitListResponse =
          await _habitService.getHabitDetail(authorization, id);
      if (habitListResponse.succeeded) {
        return habitListResponse.habit;
      }
      throw Exception(habitListResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('Unhandled', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<bool> updateHabit(String authorization, Habit habit) {
    // TODO: implement updateHabit
    throw UnimplementedError();
  }

  @override
  Future<List<Diary>> getDiaryByHabitId(String authorization, String id) async {
    try {
      final diaryListResponse =
          await _habitService.getDiaryByHabitId(authorization, id);
      if (diaryListResponse.succeeded) {
        return diaryListResponse.diaries;
      }
      throw Exception(diaryListResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('Unhandled', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> deleteHabit(String authorization, Habit habit) async {
    try {
      final diaryListResponse =
          await _habitService.deleteHabit(authorization, habit.id);
    } on DioError catch (e, stacktrace) {
      log('Unhandled', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }
}
