import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';

abstract class LocalHabitDataSource {
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> checkInHabit(Habit habit, String chosenDay, [int checkInAmount]);
  Future<void> resetHabitOnDay(Habit habit, String chosenDay);
  Future<Habit> getDetailHabit(String id);
  Future<void> saveHabits(List<Habit> habits);
  Future<void> saveDiaries(List<Diary> diaries);
  Future<List<Habit>> getAllHabit();
  Future<void> addDiary(Diary diary);
  Future<List<Diary>> getDiaries();
  Future<List<Diary>> getDiaryByHabitId(String habitId);
  Future<void> clearOffline();
  Future<void> deletePermanentlyHabit(Habit habit);
  Future<void> updateHabitAsync(Habit habit);
  Future<void> updateDiaryAsync(Diary diary);
}
