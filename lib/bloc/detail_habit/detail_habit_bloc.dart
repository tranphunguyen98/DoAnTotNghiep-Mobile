import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/entity/habit/diary_item.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/utils/date_helper.dart';

import 'bloc.dart';

class DetailHabitBloc extends Bloc<DetailHabitEvent, DetailHabitState> {
  final IHabitRepository _habitRepository;

  DetailHabitBloc({
    @required IHabitRepository habitRepository,
  })  : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(DetailHabitState.loading());

  @override
  Stream<DetailHabitState> mapEventToState(DetailHabitEvent event) async* {
    if (event is InitDataDetailHabit) {
      yield* _mapInitDataDetailHabitToState(event.habit, event.chosenDay);
    } else if (event is CheckInHabit) {
      yield* _mapCheckInHabitToState();
    } else if (event is AddDiary) {
      yield* _mapAddDiaryToState(event.item, event.date);
    } else if (event is DeleteHabit) {
      yield* _mapDeleteHabitToState();
    } else if (event is ArchiveHabit) {
      yield* _mapArchiveHabitToState();
    } else if (event is UpdateDataDetailHabit) {
      yield* _mapUpdateDataDetailHabitToState();
    }
  }

  Stream<DetailHabitState> _mapInitDataDetailHabitToState(
      Habit habit, String chosenDay) async* {
    yield state.copyWith(
        habit: habit,
        chosenDay: chosenDay,
        chosenMonth: DateTime.now().toIso8601String());
  }

  Stream<DetailHabitState> _mapAddDiaryToState(
      DiaryItem item, String dateString) async* {
    List<HabitProgressItem> habitProgress = [];
    habitProgress.addAll(state.habit.habitProgress);

    final int index = habitProgress.indexWhere(
        (element) => DateHelper.isSameDayString(element.day, dateString));
    habitProgress[index] = habitProgress[index].copyWith(diary: item);

    final habit = state.habit.copyWith(habitProgress: habitProgress);
    await _habitRepository.updateHabit(habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapDeleteHabitToState() async* {
    final habit = state.habit.copyWith(isTrashed: true);
    await _habitRepository.updateHabit(habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapCheckInHabitToState() async* {
    await _habitRepository.checkInHabit(state.habit, state.chosenDay);
    final habit = await _habitRepository.getDetailHabit(state.habit.id);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapArchiveHabitToState() async* {
    final habit = state.habit.copyWith(isFinished: true);
    await _habitRepository.updateHabit(habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapUpdateDataDetailHabitToState() async* {
    final Habit updatedHabit =
        await _habitRepository.getDetailHabit(state.habit.id);
    yield state.copyWith(habit: updatedHabit);
  }
}
