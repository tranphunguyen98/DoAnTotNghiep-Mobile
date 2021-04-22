import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/entity/habit/diary_item.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/map_const.dart';

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
      yield* _mapInitDataDetailHabitToState(event.habit);
    } else if (event is CheckInHabit) {
      yield* _mapCheckInHabitToState();
    }
    if (event is AddDiary) {
      yield* _mapAddDiaryToState(event.item);
    }
  }

  Stream<DetailHabitState> _mapInitDataDetailHabitToState(Habit habit) async* {
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapAddDiaryToState(DiaryItem item) async* {
    List<HabitProgressItem> habitProgress = [];
    habitProgress.addAll(state.habit.habitProgress);
    habitProgress.add(HabitProgressItem(
      diaries: [item],
      day: DateTime.now().toIso8601String(),
    ));

    final habit = state.habit.copyWith(habitProgress: habitProgress);
    await _habitRepository.updateHabit('authorization', habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapCheckInHabitToState() async* {
    var habit = state.habit;
    if (habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
      habit = habit.copyWith(isFinished: true);
    } else {
      List<HabitProgressItem> habitProgress = [];
      habitProgress.addAll(habit.habitProgress);
      int index = -1;
      for (int i = 0; i < habitProgress.length; i++) {
        if (DateHelper.isSameDayString(
            habitProgress[i].day, DateTime.now().toIso8601String())) {
          index = 0;
          break;
        }
      }

      if (index >= 0) {
      } else {
        habitProgress.add(HabitProgressItem(
          day: DateTime.now().toIso8601String(),
          currentCheckInAmounts: habit.missionDayCheckInStep,
        ));
      }

      habit.copyWith(habitProgress: habitProgress);
    }
    await _habitRepository.updateHabit('authorization', habit);
    yield state.copyWith(habit: habit);
  }
}
