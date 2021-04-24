import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/habit/habit.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class OpenScreenHabit extends HabitEvent {}

class ChosenDayChanged extends HabitEvent {
  final String chosenDay;

  const ChosenDayChanged({
    this.chosenDay,
  });

  @override
  List<Object> get props => [chosenDay];

  @override
  String toString() {
    return 'ChosenDayChanged{chosenDay: $chosenDay}';
  }
}

class ChangeCompletedStateHabit extends HabitEvent {
  final Habit habit;
  final int amount;

  const ChangeCompletedStateHabit({
    this.habit,
    this.amount,
  });

  @override
  List<Object> get props => [habit, amount];

  @override
  String toString() {
    return 'ChangeCompletedStateHabit{habit: $habit, amount: $amount}';
  }
}
