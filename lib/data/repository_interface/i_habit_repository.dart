import 'package:totodo/data/model/habit/habit.dart';

abstract class IHabitRepository {
  Future<bool> addHabit(Habit habit);

  Future<bool> updateHabit(Habit habit);

  Future<Habit> getDetailHabit(String id);

  Future<bool> checkInHabit(Habit habit, String chosenDay, [int checkInAmount]);

  Future<bool> resetHabitOnDay(Habit habit, String chosenDay);

  Future<List<Habit>> getAllHabit();

  Future<void> clearOffline();
}
