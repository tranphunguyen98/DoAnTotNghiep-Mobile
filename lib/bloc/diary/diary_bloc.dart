import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';
import 'package:totodo/utils/date_helper.dart';

import 'bloc.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final IHabitRepository _habitRepository;

  DiaryBloc({
    @required IHabitRepository habitRepository,
  })  : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(const DiaryState());

  @override
  Stream<DiaryState> mapEventToState(DiaryEvent event) async* {
    if (event is InitDataDiary) {
      yield* _mapInitDataDiaryToState(event.habitId);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.dateFilter, event.habitFilter);
    }
  }

  Stream<DiaryState> _mapInitDataDiaryToState(String habitId) async* {
    final List<Habit> habits = await _habitRepository.getHabits();

    if (habitId != null) {
      final Habit habitFilter = habits
          .firstWhere((element) => element.id == habitId, orElse: () => null);

      final List<DiaryItemData> diaries =
          (await _habitRepository.getDiaryByHabitId(habitId))
              .map(
                (diary) => DiaryItemData(
                    time: DateTime.parse(diary.time),
                    title: habitFilter.name,
                    content: diary.text,
                    images: diary.images,
                    emotional: diary.feeling),
              )
              .toList();
      diaries.sort((a, b) => b.time.compareTo(a.time));
      yield DiaryState(
          diaries: diaries, habits: habits, habitFilter: habitFilter);
    } else {
      //default get diaries this month
      final List<DiaryItemData> diaries =
          await getDiariesByDateFilter(DiaryState.kFilterDateNoDate);
      yield DiaryState(
          diaries: diaries,
          dateFilter: DiaryState.kFilterDateNoDate,
          habits: habits);
    }
  }

  Stream<DiaryState> _mapFilterChangedToState(
      int dateFilter, Habit habitFilter) async* {
    final newState = state.copyWith(
      diaries: await getDiariesByDateFilter(dateFilter, habitFilter),
      dateFilter: dateFilter,
      habitFilter: habitFilter,
    );
    if (habitFilter != null) {
      yield newState;
    } else {
      yield newState.setHabitFilterNull();
    }
  }

  Future<List<DiaryItemData>> getDiariesByDateFilter(int dateFilter,
      [Habit habitFilter]) async {
    final List<DiaryItemData> diaries = [];
    if (habitFilter != null) {
      diaries.addAll(await getListOfDiaryFromHabit(dateFilter, habitFilter));
    } else {
      final listHabit = await _habitRepository.getHabits();
      listHabit.removeWhere((habit) => habit.habitProgress.isEmpty ?? true);
      for (final habit in listHabit) {
        diaries.addAll(await getListOfDiaryFromHabit(dateFilter, habit));
      }
    }

    diaries.sort((a, b) => b.time.compareTo(a.time));

    return diaries;
  }

  Future<List<DiaryItemData>> getListOfDiaryFromHabit(
      int dateFilter, Habit habit) async {
    final diaries = await _habitRepository.getDiaryByHabitId(habit.id);
    final listDiary = diaries
        .where((diary) {
          bool dateCondition = true;
          switch (dateFilter) {
            case DiaryState.kFilterDateNoDate:
              dateCondition = true;
              break;
            case DiaryState.kFilterDateThisWeek:
              dateCondition = DateHelper.isInCurrentWeekString(diary.time);
              break;
            case DiaryState.kFilterDateThisMonth:
              dateCondition = DateHelper.isInCurrentMonthString(diary.time);
              break;
            case DiaryState.kFilterDateThisYear:
              dateCondition = DateHelper.isInCurrentYearString(diary.time);
              break;
          }
          return dateCondition;
        })
        .map(
          (diary) => DiaryItemData(
              time: DateTime.parse(diary.time),
              title: habit.name,
              content: diary.text,
              images: diary.images,
              emotional: diary.feeling),
        )
        .toList();
    return listDiary;
  }
}
