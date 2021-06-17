import 'package:totodo/data/model/habit/habit.dart';

abstract class LocalHabitDataSource {
  Future<bool> addHabit(Habit habit);
  Future<bool> updateHabit(Habit habit);
  Future<bool> checkInHabit(Habit habit, String chosenDay, [int checkInAmount]);
  Future<bool> resetHabitOnDay(Habit habit, String chosenDay);
  Future<Habit> getDetailHabit(String id);
  Future<List<Habit>> getAllHabit();
  Future<void> clearOffline();
}
