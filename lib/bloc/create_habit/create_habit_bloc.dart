import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';

import 'bloc.dart';

class CreateHabitBloc extends Bloc<CreateHabitEvent, CreateHabitState> {
  final IHabitRepository _habitRepository;

  CreateHabitBloc({@required IHabitRepository habitRepository})
      : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(CreateHabitState());

  @override
  Stream<CreateHabitState> mapEventToState(CreateHabitEvent event) async* {
    if (event is OpenScreenCreateHabit) {
      yield* _mapOpenScreenCreateHabitToState(event.habit);
    } else if (event is CreatingHabitDataChanged) {
      yield* _mapCreatingHabitDataChangedToState(event);
    } else if (event is SubmitCreatingHabit) {
      yield* _mapSubmitCreatingHabitToState();
    }
  }

  Stream<CreateHabitState> _mapOpenScreenCreateHabitToState(
      Habit habit) async* {
    yield state.copyWith(habit: habit);
  }

  Stream<CreateHabitState> _mapSubmitEditingHabitToState() async* {
    final Habit habit =
        state.habit.copyWith(updatedDate: DateTime.now().toIso8601String());

    await _habitRepository.updateHabit(habit);

    //TODO add reminder
    // if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
    //   showNotificationScheduledWithTask(taskSubmit);
    // }

    yield state.copyWith(
      success: true,
      habit: Habit(),
    );
  }

  Stream<CreateHabitState> _mapSubmitCreatingHabitToState() async* {
    Habit habit = state.habit;
    if (state.habit.id?.isEmpty ?? true) {
      habit = state.habit.copyWith(
          id: state.habit.id ??
              DateTime.now().microsecondsSinceEpoch.toString(),
          createdDate: DateTime.now().toIso8601String());
      await _habitRepository.addHabit(habit);
    } else {
      habit =
          state.habit.copyWith(updatedDate: DateTime.now().toIso8601String());
      await _habitRepository.updateHabit(habit);
    }

    //TODO add reminder
    // if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
    //   showNotificationScheduledWithTask(taskSubmit);
    // }

    yield state.copyWith(
      success: true,
      habit: Habit(),
    );
  }

  Stream<CreateHabitState> _mapCreatingHabitDataChangedToState(
      CreatingHabitDataChanged event) async* {
    var habit = state.habit;
    habit = habit.copyWith(name: event.name);
    habit = habit.copyWith(icon: event.icon);
    habit = habit.copyWith(motivation: event.motivation);
    habit = habit.copyWith(type: event.type);
    habit = habit.copyWith(frequency: event.frequency);
    habit = habit.copyWith(reminds: event.reminds);
    habit = habit.copyWith(missionDayUnit: event.missionDayUnit);
    habit = habit.copyWith(missionDayCheckInStep: event.missionDayCheckInStep);
    habit = habit.copyWith(totalDayAmount: event.totalDayAmount);
    habit = habit.copyWith(typeHabitGoal: event.typeHabitGoal);
    habit = habit.copyWith(
        typeHabitMissionDayCheckIn: event.typeHabitMissionDayCheckIn);
    yield state.copyWith(habit: habit);
  }
}
