import 'package:totodo/data/entity/habit/habit.dart';

abstract class LocalHabitDataSource {
  Future<bool> addHabit(String authorization, Habit habit);
  Future<bool> updateHabit(String authorization, Habit habit);
  Future<Habit> getDetailHabit(String authorization, String id);
  Future<List<Habit>> getAllHabit(
    String authorization,
  );
  Future<void> clearOffline();
}
