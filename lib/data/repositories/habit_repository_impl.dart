import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/entity/habit/habit.dart';

class HabitRepositoryImpl implements IHabitRepository {
  final RemoteHabitDataSource _remoteHabitDataSource;
  final LocalHabitDataSource _localHabitDataSource;

  HabitRepositoryImpl(this._remoteHabitDataSource, this._localHabitDataSource);

  @override
  Future<void> clearOffline() async {
    _localHabitDataSource.clearOffline();
  }

  @override
  Future<bool> addHabit(String authorization, Habit habit) async {
    return _localHabitDataSource.addHabit(authorization, habit);
  }

  @override
  Future<List<Habit>> getAllHabit(String authorization) {
    return _localHabitDataSource.getAllHabit(authorization);
  }

  @override
  Future<Habit> getDetailHabit(String authorization, String id) {
    return _localHabitDataSource.getDetailHabit(authorization, id);
  }

  @override
  Future<bool> updateHabit(String authorization, Habit habit) {
    return _localHabitDataSource.updateHabit(authorization, habit);
  }
}
