import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/entity/habit/habit.dart';

import 'local_habit_service.dart';

class LocalHabitDataSourceImplement implements LocalHabitDataSource {
  final LocalHabitService _habitService;

  const LocalHabitDataSourceImplement(this._habitService);

  @override
  Future<bool> addHabit(String authorization, Habit habit) {
    return _habitService.addHabit(habit);
  }

  @override
  Future<void> clearOffline() {
    return _habitService.clearData();
  }

  @override
  Future<List<Habit>> getAllHabit(String authorization) {
    return _habitService.getAllHabit();
  }

  @override
  Future<Habit> getDetailHabit(String authorization, String id) {
    return _habitService.getHabitFromId(id);
  }

  @override
  Future<bool> updateHabit(String authorization, Habit habit) {
    return _habitService.updateHabit(habit);
  }
}
