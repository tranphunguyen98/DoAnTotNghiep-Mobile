import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/local/source/habit/local_diary_service.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';

import 'local_habit_service.dart';

class LocalHabitDataSourceImplement implements LocalHabitDataSource {
  final LocalHabitService _habitService;
  final LocalDiaryService _diaryService;

  const LocalHabitDataSourceImplement(this._habitService, this._diaryService);

  @override
  Future<bool> addHabit(Habit habit) {
    return _habitService.addHabit(habit);
  }

  @override
  Future<void> clearOffline() {
    return _habitService.clearData();
  }

  @override
  Future<List<Habit>> getAllHabit() {
    return _habitService.getAllHabit();
  }

  @override
  Future<Habit> getDetailHabit(String id) {
    return _habitService.getHabitFromId(id);
  }

  @override
  Future<bool> updateHabit(Habit habit) {
    return _habitService.updateHabit(habit);
  }

  @override
  Future<bool> checkInHabit(Habit habit, String chosenDay,
      [int checkInAmount]) {
    return _habitService.checkInHabit(habit, chosenDay, checkInAmount);
  }

  @override
  Future<bool> resetHabitOnDay(Habit habit, String chosenDay) {
    return _habitService.resetHabitOnDay(habit, chosenDay);
  }

  @override
  Future<void> saveHabits(List<Habit> habits) {
    return _habitService.saveHabits(habits);
  }

  @override
  Future<List<Diary>> getDiaries() {
    return _diaryService.getAllDiary();
  }

  @override
  Future<List<Diary>> getDiaryByHabitId(String habitId) {
    return _diaryService.getDiaryFromHabitId(habitId);
  }

  @override
  Future<void> saveDiaries(List<Diary> diaries) {
    return _diaryService.saveDiaries(diaries);
  }

  @override
  Future<void> addDiary(Diary diary) {
    return _diaryService.addDiary(diary);
  }

  @override
  Future<void> updateHabitAsync(Habit habit) {
    return _habitService.updateHabitAsync(habit);
  }

  @override
  Future<void> deletePermanentlyHabit(Habit habit) {
    return _habitService.permanentlyDeleteTask(habit.id);
  }

  @override
  Future<void> updateDiaryAsync(Diary diary) {
    return _diaryService.updateDiary(diary);
  }
}
