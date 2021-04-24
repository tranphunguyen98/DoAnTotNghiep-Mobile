import 'package:totodo/data/entity/habit/habit.dart';

abstract class IHabitRepository {
  Future<bool> addHabit(String authorization, Habit habit);

  Future<bool> updateHabit(String authorization, Habit habit);

  Future<Habit> getDetailHabit(String authorization, String id);

  Future<bool> checkInHabit(String authorization, Habit habit, String chosenDay,
      [int checkInAmount]);

  Future<bool> resetHabitOnDay(
      String authorization, Habit habit, String chosenDay);

  Future<List<Habit>> getAllHabit(
    String authorization,
  );

  Future<void> clearOffline();
}
