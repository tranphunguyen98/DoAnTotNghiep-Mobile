import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/utils/cron_helper.dart';

class HabitState extends Equatable {
  final List<Habit> _listHabit;
  final String chosenDay;
  final bool loading;
  final bool success;
  final String msg;

  HabitState({
    List<Habit> listHabit,
    String chosenDay,
    this.loading = false,
    this.success = false,
    this.msg,
  })  : _listHabit = listHabit ?? [],
        chosenDay = chosenDay ?? DateTime.now().toIso8601String();

  List<Habit> get listHabitWithChosenDay {
    final list = _listHabit
        .where((habit) =>
            !habit.isFinished &&
            CronHelper.instance
                .checkTimeIsInCron(DateTime.parse(chosenDay), habit.cronDay))
        .toList();
    // log("lengthHabit=", _listHabit.length);
    // log("length=", list.length);
    return list;
  }

  List<Habit> get listActiveHabit {
    return _listHabit.where((habit) => !habit.isFinished).toList();
  }

  List<Habit> get listArchivedHabit {
    return _listHabit.where((habit) => habit.isFinished).toList();
  }

  HabitState copyWith({
    List<Habit> listHabit,
    String chosenDay,
    bool loading,
    bool success,
    String msg,
  }) {
    if ((listHabit == null || identical(listHabit, _listHabit)) &&
        (chosenDay == null || identical(chosenDay, this.chosenDay)) &&
        (loading == null || identical(loading, this.loading)) &&
        (success == null || identical(success, this.success)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return HabitState(
      listHabit: listHabit ?? _listHabit,
      chosenDay: chosenDay ?? this.chosenDay,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      msg: msg ?? this.msg,
    );
  }

  @override
  String toString() {
    return 'HabitState{success: $success}';
  }

  @override
  List<Object> get props => [_listHabit, chosenDay, loading, msg, success];
}
