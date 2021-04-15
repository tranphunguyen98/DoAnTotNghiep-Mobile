import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/remote/habit/remote_habit_service.dart';

class RemoteHabitDataSourceImpl implements RemoteHabitDataSource {
  final RemoteHabitService _habitService;

  RemoteHabitDataSourceImpl(this._habitService);

  @override
  Future<bool> addHabit(String authorization, Habit habit) {
    // TODO: implement addHabit
    throw UnimplementedError();
  }

  @override
  Future<void> clearOffline() {
    // TODO: implement clearOffline
    throw UnimplementedError();
  }

  @override
  Future<List<Habit>> getAllHabit(String authorization) {
    // TODO: implement getAllHabit
    throw UnimplementedError();
  }

  @override
  Future<Habit> getDetailHabit(String authorization, String id) {
    // TODO: implement getDetailHabit
    throw UnimplementedError();
  }

  @override
  Future<bool> updateHabit(String authorization, Habit habit) {
    // TODO: implement updateHabit
    throw UnimplementedError();
  }
}
