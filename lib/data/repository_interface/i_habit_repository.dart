import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';

abstract class IHabitRepository {
  Future<void> addHabit(Habit habit);

  Future<void> updateHabit(Habit habit);

  Future<void> deleteHabit(Habit habit);

  Future<Habit> getDetailHabit(String id);

  Future<void> checkInHabit(Habit habit, String chosenDay, [int checkInAmount]);

  Future<void> resetHabitOnDay(Habit habit, String chosenDay);

  Future<List<Habit>> getHabits();

  Future<void> addDiary(String habitId, Diary diary);

  Future<List<Diary>> getDiaries();

  Future<List<Diary>> getDiaryByHabitId(String habitId);

  Future<void> saveDataOnLocal();

  Future<void> clearOffline();
}
