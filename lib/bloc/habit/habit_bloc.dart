import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/utils/date_helper.dart';

import 'bloc.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final IHabitRepository _habitRepository;

  HabitBloc({@required IHabitRepository habitRepository})
      : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(HabitState());

  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    if (event is OpenScreenHabit) {
      yield* _mapOpenScreenHabitToState();
    } else if (event is ChosenDayChanged) {
      yield* _mapChosenDayChangedToState(event.chosenDay);
    } else if (event is ChangeCompletedStateHabit) {
      yield* _mapChangeCompletedStateHabitToState(event.habit, event.amount);
    }
  }

  Stream<HabitState> _mapOpenScreenHabitToState() async* {
    //TODO add try catch
    state.copyWith(loading: true);
    final listHabit = <Habit>[];
    listHabit.addAll(await _habitRepository.getAllHabit());
    yield state.copyWith(
        listHabit: listHabit.where((habit) => !habit.isTrashed).toList(),
        loading: false);
  }

  Stream<HabitState> _mapChosenDayChangedToState(String date) async* {
    yield state.copyWith(chosenDay: date);
  }

  Stream<HabitState> _mapChangeCompletedStateHabitToState(
      Habit habit, int amount) async* {
    bool isDone = false;
    for (final habitProgress in habit.habitProgress) {
      if (DateHelper.isSameDayString(habitProgress.day, state.chosenDay)) {
        if (habitProgress.isDone) {
          isDone = true;
        }
        break;
      }
    }

    if (!isDone) {
      await _habitRepository.checkInHabit(habit, state.chosenDay);
    } else {
      await _habitRepository.resetHabitOnDay(habit, state.chosenDay);
    }

    final listHabit = await _habitRepository.getAllHabit();

    yield state.copyWith(listHabit: listHabit);
  }
}
