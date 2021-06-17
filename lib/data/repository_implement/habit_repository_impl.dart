import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';

class HabitRepositoryImpl implements IHabitRepository {
  final RemoteHabitDataSource _remoteHabitDataSource;
  final LocalHabitDataSource _localHabitDataSource;

  HabitRepositoryImpl(this._remoteHabitDataSource, this._localHabitDataSource);

  @override
  Future<void> clearOffline() async {
    _localHabitDataSource.clearOffline();
  }

  @override
  Future<bool> addHabit(Habit habit) async {
    return _localHabitDataSource.addHabit(habit);
  }

  @override
  Future<List<Habit>> getAllHabit() {
    return _localHabitDataSource.getAllHabit();
  }

  @override
  Future<Habit> getDetailHabit(String id) {
    return _localHabitDataSource.getDetailHabit(id);
  }

  @override
  Future<bool> updateHabit(Habit habit) {
    return _localHabitDataSource.updateHabit(habit);
  }

  @override
  Future<bool> checkInHabit(Habit habit, String chosenDay,
      [int checkInAmount]) {
    return _localHabitDataSource.checkInHabit(habit, chosenDay);
  }

  @override
  Future<bool> resetHabitOnDay(Habit habit, String chosenDay) {
    return _localHabitDataSource.resetHabitOnDay(habit, chosenDay);
  }
}
