import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/entity/habit/habit_frequency.dart';
import 'package:totodo/data/entity/habit/habit_icon.dart';
import 'package:totodo/data/entity/habit/habit_motivation.dart';
import 'package:totodo/data/entity/habit/habit_remind.dart';

abstract class CreateHabitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenScreenCreateHabit extends CreateHabitEvent {
  final Habit habit;

  OpenScreenCreateHabit(this.habit);

  @override
  List<Object> get props => [habit];

  @override
  String toString() {
    return 'OpenScreenCreateHabit{habit: $habit}';
  }
}

class CreatingHabitDataChanged extends CreateHabitEvent {
  final String name;
  final int type;
  final HabitIcon icon;
  final HabitMotivation motivation;
  final HabitFrequency frequency;
  final List<HabitRemind> reminds;
  final int missionDayUnit;
  final int missionDayCheckInStep;
  final int totalDayAmount;
  final int typeHabitGoal;

  CreatingHabitDataChanged(
      {this.name,
      this.type,
      this.icon,
      this.motivation,
      this.frequency,
      this.reminds,
      this.missionDayUnit,
      this.missionDayCheckInStep,
      this.totalDayAmount,
      this.typeHabitGoal});

  @override
  List<Object> get props => [
        name,
        type,
        icon,
        motivation,
        frequency,
        reminds,
        missionDayUnit,
        missionDayCheckInStep,
        totalDayAmount,
        typeHabitGoal
      ];

  @override
  String toString() {
    return 'CreatingHabitDataChanged{name: $name, type: $type, icon: $icon, motivation: $motivation, frequency: $frequency, reminds: $reminds, missionDayUnit: $missionDayUnit, missionDayCheckInStep: $missionDayCheckInStep, totalDayAmount: $totalDayAmount, typeHabitGoal: $typeHabitGoal}';
  }
}

class SubmitCreatingHabit extends CreateHabitEvent {}
