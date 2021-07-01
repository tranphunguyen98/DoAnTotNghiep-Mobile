import 'package:equatable/equatable.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_frequency.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/data/model/habit/habit_motivation.dart';
import 'package:totodo/data/model/habit/habit_remind.dart';

//TODO Change Name
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

class AddError extends CreateHabitEvent {
  final String error;

  AddError(this.error);

  @override
  List<Object> get props => [error];
}

class CreatingHabitDataChanged extends CreateHabitEvent {
  final String name;
  final int type;
  final HabitIcon icon;
  final HabitMotivation motivation;
  final HabitFrequency frequency;
  final List<HabitRemind> remind;
  final int missionDayUnit;
  final int missionDayCheckInStep;
  final int missionDayTarget;
  final int typeHabitGoal;
  final int typeHabitMissionDayCheckIn;

  CreatingHabitDataChanged(
      {this.name,
      this.type,
      this.icon,
      this.motivation,
      this.frequency,
      this.remind,
      this.missionDayUnit,
      this.missionDayCheckInStep,
      this.missionDayTarget,
      this.typeHabitGoal,
      this.typeHabitMissionDayCheckIn});

  @override
  List<Object> get props => [
        name,
        type,
        icon,
        motivation,
        frequency,
        remind,
        missionDayUnit,
        missionDayCheckInStep,
        missionDayTarget,
        typeHabitGoal,
        typeHabitMissionDayCheckIn
      ];

  @override
  String toString() {
    return 'CreatingHabitDataChanged{name: $name, type: $type, icon: $icon, motivation: $motivation, frequency: $frequency, remind: $remind, missionDayUnit: $missionDayUnit, missionDayCheckInStep: $missionDayCheckInStep, missionDayTarget: $missionDayTarget, typeHabitGoal: $typeHabitGoal, typeHabitMissionDayCheckIn: $typeHabitMissionDayCheckIn}';
  }
}

class SubmitCreatingHabit extends CreateHabitEvent {}

// class SubmitEditingHabit extends CreateHabitEvent {}
