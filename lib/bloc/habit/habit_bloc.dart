import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';

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
    }
  }

  Stream<HabitState> _mapOpenScreenHabitToState() async* {
    //TODO add try catch
    final listHabit = await _habitRepository.getAllHabit('authorization');
    yield state.copyWith(listHabit: listHabit);
  }

  Stream<HabitState> _mapChosenDayChangedToState(String date) async* {
    yield state.copyWith(chosenDay: date);
  }
}
