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

    log("LIST HABIT: ${listHabit.length}");
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

  Future<bool> checkInHabit(Habit habit, String chosenDay,
      [int checkInAmount]) async {
    final habitProgress = <HabitProgressItem>[];
    habitProgress.addAll(habit.habitProgress);

    bool isContainDay = false;
    for (int i = 0; i < habitProgress.length; i++) {
      if (DateHelper.isSameDayString(habitProgress[i].day, chosenDay)) {
        log("EHabitMissionDayCheckIn1 ${habit.typeHabitMissionDayCheckIn}");
        if (habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
          habitProgress[i] =
              habitProgress[i].copyWith(isDone: !habitProgress[i].isDone);
        } else {
          if (habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.auto.index) {
            habitProgress[i] = habitProgress[i].copyWith(
              currentCheckInAmounts: habitProgress[i].currentCheckInAmounts +
                  habit.missionDayCheckInStep,
            );
            if (habitProgress[i].currentCheckInAmounts >=
                habit.totalDayAmount) {
              habitProgress[i] = habitProgress[i].copyWith(isDone: true);
            }
          } else if (habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.completedAll.index) {
            log("EHabitMissionDayCheckIn1");
            habitProgress[i] = habitProgress[i].copyWith(
                isDone: true, currentCheckInAmounts: habit.totalDayAmount);
          }
        }
        isContainDay = true;
        break;
      }
    }

    if (!isContainDay) {
      if (habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
        habitProgress.add(HabitProgressItem(day: chosenDay, isDone: true));
      } else {
        if (habit.typeHabitMissionDayCheckIn ==
            EHabitMissionDayCheckIn.auto.index) {
          habitProgress.add(HabitProgressItem(
              day: chosenDay,
              currentCheckInAmounts: habit.missionDayCheckInStep,
              isDone: habit.missionDayCheckInStep >= habit.totalDayAmount));
        } else if (habit.typeHabitMissionDayCheckIn ==
            EHabitMissionDayCheckIn.completedAll.index) {
          habitProgress.add(HabitProgressItem(
              day: chosenDay,
              currentCheckInAmounts: habit.totalDayAmount,
              isDone: true));
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
      if (DateHelper.isSameDayString(progress[i].day, chosenDay)) {
        progress[i] =
            progress[i].copyWith(currentCheckInAmounts: 0, isDone: false);
        break;
      }
    }
    updateHabit(habit.copyWith(habitProgress: progress));
    return true;
  } //</editor-fold>

  Future<void> clearData() async {
    _habitBoxHabit.clear();
  }
}
