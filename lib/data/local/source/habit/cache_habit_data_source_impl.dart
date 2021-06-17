import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/model/habit/habit.dart';

import 'local_habit_service.dart';

class LocalHabitDataSourceImplement implements LocalHabitDataSource {
  final LocalHabitService _habitService;

  const LocalHabitDataSourceImplement(this._habitService);

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
    return _habitService.checkInHabit(habit, chosenDay);
  }

  @override
  Future<bool> resetHabitOnDay(Habit habit, String chosenDay) {
    return _habitService.resetHabitOnDay(habit, chosenDay);
  }
}
