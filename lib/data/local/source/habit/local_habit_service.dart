import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/utils/util.dart';

@Injectable()
class LocalHabitService {
  static const kNameBoxHabit = "habit";

  Box _habitBoxHabit;

  LocalHabitService() {
    _habitBoxHabit = Hive.box(kNameBoxHabit);
  }

  Future<bool> addHabit(Habit habit) async {
    if (habit.id == null) {
      _habitBoxHabit.add(
          habit.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    }
    // log('habitcreate', habit);
    _habitBoxHabit.add(habit);
    return true;
  }

  Future<List<Habit>> getAllHabit() async {
    final listHabit = <Habit>[];
    // _habitBoxHabit.clear();
    for (var i = 0; i < _habitBoxHabit.length; i++) {
      listHabit.add(_habitBoxHabit.getAt(i) as Habit);
    }

    log("LIST HABIT: ${listHabit}");
    return listHabit ?? <Habit>[];
  }

  Future<Habit> getHabitFromId(String idHabit) async {
    final habit = await _habitBoxHabit.values
        .firstWhere((element) => (element as Habit).id == idHabit) as Habit;

    return habit;
  }

  Future<bool> updateHabit(Habit habit) async {
    int indexUpdated = -1;

    for (var i = 0; i < _habitBoxHabit.length; i++) {
      if ((_habitBoxHabit.getAt(i) as Habit).id == habit.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _habitBoxHabit.putAt(indexUpdated, habit);
      return true;
    }
    return false;
  }

  //</editor-fold>

  Future<void> clearData() async {
    _habitBoxHabit.clear();
  }
}
