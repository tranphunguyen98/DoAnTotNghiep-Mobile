import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/entity/habit/habit.dart';

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
      Habit _habit) async* {
    yield state.copyWith(habit: _habit);
  }

  Stream<CreateHabitState> _mapSubmitCreatingHabitToState() async* {
    final Habit habit = state.habit.copyWith(
      id: state.habit.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
    );

    await _habitRepository.addHabit('test', habit);

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
    yield state.copyWith(habit: habit);
  }
}
