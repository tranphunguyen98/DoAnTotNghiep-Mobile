import 'package:equatable/equatable.dart';
import 'package:totodo/data/model/habit/habit.dart';

class CreateHabitState extends Equatable {
  final Habit habit;
  final bool loading;
  final bool success;
  final String msg;

  CreateHabitState({
    Habit habit,
    this.loading = false,
    this.success = false,
    this.msg,
  }) : habit = habit ?? Habit();

  CreateHabitState updateHabit(Habit habit) {
    return copyWith(habit: habit);
  }

  CreateHabitState copyWith({
    Habit habit,
    bool loading,
    bool success,
    String msg,
  }) {
    if ((habit == null || identical(habit, this.habit)) &&
        (loading == null || identical(loading, this.loading)) &&
        (success == null || identical(success, this.success)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return CreateHabitState(
      habit: habit ?? this.habit,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      msg: msg ?? this.msg,
    );
  }

  @override
  String toString() {
    return 'CreateHabitState{habit: $habit, loading: $loading, success: $success, msg: $msg}';
  }

  @override
  List<Object> get props => [habit, loading, msg, success];
}
