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
      yield* _mapInitDataDiaryToState(event.diaries);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.dateFilter, event.habitFilter);
    }
  }

  Stream<DiaryState> _mapInitDataDiaryToState(
      List<DiaryItemData> diaries) async* {
    final List<Habit> habits = await _habitRepository.getAllHabit();
    if (diaries != null) {
      yield DiaryState(diaries: diaries, habits: habits);
    } else {
      //default get diaries this month
      final List<DiaryItemData> diaries =
          await getDiariesByDateFilter(DiaryState.kFilterDateThisMonth);
      yield DiaryState(
          diaries: diaries,
          dateFilter: DiaryState.kFilterDateThisMonth,
          habits: habits);
    }
  }

  Stream<DiaryState> _mapFilterChangedToState(
      int dateFilter, Habit habitFilter) async* {
    yield state.copyWith(
      diaries: await getDiariesByDateFilter(dateFilter, habitFilter),
      dateFilter: dateFilter,
      habitFilter: habitFilter,
    );
  }

  Future<List<DiaryItemData>> getDiariesByDateFilter(int dateFilter,
      [Habit habitFilter]) async {
    final List<DiaryItemData> diaries = [];

    if (habitFilter != null) {
      diaries.addAll(getListOfDiaryFromHabit(dateFilter, habitFilter));
    } else {
      final listHabit = await _habitRepository.getAllHabit();
      listHabit.removeWhere((habit) => habit.habitProgress.isEmpty ?? true);
      for (final habit in listHabit) {
        diaries.addAll(getListOfDiaryFromHabit(dateFilter, habit));
      }
    }

    diaries.sort((a, b) => b.date.compareTo(a.date));

    return diaries;
  }

  List<DiaryItemData> getListOfDiaryFromHabit(int dateFilter, Habit habit) {
    final listDiary = habit.habitProgress
        .where((habitProgress) {
          bool dateCondition = true;
          switch (dateFilter) {
            case DiaryState.kFilterDateNoDate:
              dateCondition = true;
              break;
            case DiaryState.kFilterDateThisWeek:
              dateCondition =
                  DateHelper.isInCurrentWeekString(habitProgress.day);
              break;
            case DiaryState.kFilterDateThisMonth:
              dateCondition =
                  DateHelper.isInCurrentMonthString(habitProgress.day);
              break;
            case DiaryState.kFilterDateThisYear:
              dateCondition =
                  DateHelper.isInCurrentYearString(habitProgress.day);
              break;
          }
          return habitProgress.diary != null && dateCondition;
        })
        .map(
          (itemProgress) => DiaryItemData(
            date: DateTime.parse(itemProgress.day),
            title: habit.name,
            content: itemProgress.diary.text,
            images: itemProgress.diary.images,
          ),
        )
        .toList();
    return listDiary;
  }
}
