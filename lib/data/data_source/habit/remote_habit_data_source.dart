import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';

abstract class RemoteHabitDataSource {
  Future<bool> addHabit(String authorization, Habit habit);
  Future<void> addDiary(String authorization, String habitId, Diary diary);
  Future<Habit> updateHabit(String authorization, Habit habit);
  Future<Habit> getDetailHabit(String authorization, String habitId);
  Future<List<Diary>> getDiaryByHabitId(String authorization, String habitId);
  Future<List<Habit>> getAllHabit(
    String authorization,
  );
  Future<void> deleteHabit(String authorization, Habit habit);
  Future<void> clearOffline();
}
