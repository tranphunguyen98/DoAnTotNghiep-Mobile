import 'package:equatable/equatable.dart';

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
