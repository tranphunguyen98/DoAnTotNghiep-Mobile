import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/remote/source/habit/remote_habit_service.dart';
import 'package:totodo/utils/util.dart';

import '../../exception/unauthenticated_exception.dart';

class RemoteHabitDataSourceImpl implements RemoteHabitDataSource {
  final RemoteHabitService _habitService;

  RemoteHabitDataSourceImpl(this._habitService);

  @override
  Future<bool> addHabit(String authorization, Habit habit) async {
    final response = await _habitService.addHabit(
        authorization,
        habit.id,
        habit.name,
        jsonEncode(habit.icon.toJson()),
        jsonEncode(habit.images.toJson()),
        jsonEncode(habit.remind.map((e) => e.toJson()).toList()),
        jsonEncode(habit.motivation.toJson()),
        jsonEncode(habit.frequency.toJson()),
        habit.missionDayUnit,
        habit.missionDayCheckInStep,
        habit.missionDayTarget);
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
        habitListResponse.habits.removeWhere((element) => element == null);
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
  Future<Habit> updateHabit(String authorization, Habit habit) async {
    try {
      final response = await _habitService.updateHabit(
          authorization,
          habit.id,
          habit.name,
          jsonEncode(habit.icon.toJson()),
          jsonEncode(habit.images.toJson()),
          jsonEncode(habit.remind.map((e) => e.toJson()).toList()),
          jsonEncode(habit.motivation.toJson()),
          jsonEncode(habit.frequency.toJson()),
          jsonEncode(habit.habitProgress.map((e) => e.toJson()).toList()),
          habit.missionDayUnit,
          habit.missionDayCheckInStep,
          habit.missionDayTarget,
          habit.isFinished);
      return response.habit;
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
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

  @override
  Future<void> addDiary(
      String authorization, String habitId, Diary diary) async {
    try {
      final response = await _habitService.addDiary(
          authorization, habitId, diary.text, diary.feeling, diary.time);
      ;
    } on DioError catch (e, stacktrace) {
      log('Unhandled', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }
}
