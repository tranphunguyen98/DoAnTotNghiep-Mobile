import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/habit/habit.dart';

class HabitState extends Equatable {
  final List<Habit> listHabit;
  final bool loading;
  final bool success;
  final String msg;

  HabitState({
    List<Habit> listHabit,
    this.loading = false,
    this.success = false,
    this.msg,
  }) : listHabit = listHabit ?? [];

  HabitState copyWith({
    List<Habit> listHabit,
    bool loading,
    bool success,
    String msg,
  }) {
    if ((listHabit == null || identical(listHabit, this.listHabit)) &&
        (loading == null || identical(loading, this.loading)) &&
        (success == null || identical(success, this.success)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return HabitState(
      listHabit: listHabit ?? this.listHabit,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      msg: msg ?? this.msg,
    );
  }

  @override
  String toString() {
    return 'CreateHabitState{listHabit: $listHabit, loading: $loading, success: $success, msg: $msg}';
  }

  @override
  List<Object> get props => [listHabit, loading, msg, success];
}
