import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_progress_item.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

@Injectable()
class LocalHabitService {
  static const kNameBoxHabit = "habit";

  Box _habitBox;

  LocalHabitService() {
    _habitBox = Hive.box(kNameBoxHabit);
  }

  Future<bool> addHabit(Habit habit) async {
    if (habit.id == null) {
      _habitBox.add(
          habit.copyWith(id: DateTime.now().microsecondsSinceEpoch.toString()));
      return true;
    } else {
      _habitBox.add(habit);
    }
    // log('habitcreate', habit);
    return true;
  }

  Future<List<Habit>> getAllHabit() async {
    final listHabit = <Habit>[];
    // _habitBoxHabit.clear();
    for (var i = 0; i < _habitBox.length; i++) {
      listHabit.add(_habitBox.getAt(i) as Habit);
    }

    log("LIST HABIT: ${listHabit.length}");
    return listHabit ?? <Habit>[];
  }

  Future<Habit> getHabitFromId(String idHabit) async {
    final habit = await _habitBox.values
        .firstWhere((element) => (element as Habit).id == idHabit) as Habit;

    return habit;
  }

  Future<bool> updateHabit(Habit habit) async {
    int indexUpdated = -1;

    for (var i = 0; i < _habitBox.length; i++) {
      if ((_habitBox.getAt(i) as Habit).id == habit.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _habitBox.putAt(indexUpdated,
          habit.copyWith(updatedAt: DateTime.now().toIso8601String()));
      return true;
    }
    return false;
  }

  Future<bool> updateHabitAsync(Habit habit) async {
    int indexUpdated = -1;

    for (var i = 0; i < _habitBox.length; i++) {
      if ((_habitBox.getAt(i) as Habit).id == habit.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _habitBox.putAt(indexUpdated, habit);
      return true;
    }
    return false;
  }

  Future<bool> checkInHabit(Habit habit, String chosenDay,
      [int checkInAmount]) async {
    final habitProgress = <HabitProgressItem>[];
    habitProgress.addAll(habit.habitProgress);

    bool isContainDay = false;
    for (int i = 0; i < habitProgress.length; i++) {
      if (DateHelper.isSameDayString(habitProgress[i].date, chosenDay)) {
        log("EHabitMissionDayCheckIn1 ${habit.typeHabitMissionDayCheckIn}");
        if (habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
          habitProgress[i] =
              habitProgress[i].copyWith(isDone: !habitProgress[i].isDone);
        } else {
          if (habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.auto.index) {
            habitProgress[i] = habitProgress[i].copyWith(
              current: habitProgress[i].current + habit.missionDayCheckInStep,
            );
            if (habitProgress[i].current >= habit.missionDayTarget) {
              habitProgress[i] = habitProgress[i].copyWith(isDone: true);
            }
          } else if (habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.completedAll.index) {
            log("EHabitMissionDayCheckIn1");
            habitProgress[i] = habitProgress[i]
                .copyWith(isDone: true, current: habit.missionDayTarget);
          }
        }
        isContainDay = true;
        break;
      }
    }

    if (!isContainDay) {
      if (habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
        habitProgress.add(HabitProgressItem(date: chosenDay, isDone: true));
      } else {
        if (habit.typeHabitMissionDayCheckIn ==
            EHabitMissionDayCheckIn.auto.index) {
          habitProgress.add(HabitProgressItem(
              date: chosenDay,
              current: habit.missionDayCheckInStep,
              isDone: habit.missionDayCheckInStep >= habit.missionDayTarget));
        } else if (habit.typeHabitMissionDayCheckIn ==
            EHabitMissionDayCheckIn.completedAll.index) {
          habitProgress.add(HabitProgressItem(
              date: chosenDay, current: habit.missionDayTarget, isDone: true));
        }
      }
    }

    updateHabit(habit.copyWith(habitProgress: habitProgress));
    return true;
  }

  Future<bool> resetHabitOnDay(Habit habit, String chosenDay) async {
    final progress = <HabitProgressItem>[];
    progress.addAll(habit.habitProgress);

    for (int i = 0; i < progress.length; i++) {
      if (DateHelper.isSameDayString(progress[i].date, chosenDay)) {
        progress[i] = progress[i].copyWith(current: 0, isDone: false);
        break;
      }
    }
    updateHabit(habit.copyWith(habitProgress: progress));
    return true;
  } //</editor-fold>

  Future<void> saveHabits(List<Habit> habits) async {
    await _habitBox.clear();
    for (final habit in habits) {
      await _habitBox.add(habit);
    }

    final a = await getAllHabit();
    log('a', a);
  }

  Future<void> clearData() async {
    _habitBox.clear();
  }

  Future<void> permanentlyDeleteTask(String habitId) async {
    int indexUpdated = -1;

    for (var i = 0; i < _habitBox.length; i++) {
      if ((_habitBox.getAt(i) as Habit).id == habitId) {
        indexUpdated = i;
        break;
      }
    }

    if (indexUpdated > -1) {
      _habitBox.deleteAt(indexUpdated);
    }
  }
}
