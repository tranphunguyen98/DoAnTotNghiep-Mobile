import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/map_const.dart';
import 'package:totodo/utils/util.dart';

@immutable
class DetailHabitState extends Equatable {
  final Habit habit;
  final String chosenDay;
  final bool loading;
  final String chosenMonth;

  const DetailHabitState({
    this.habit,
    this.chosenDay,
    this.chosenMonth,
    this.loading,
  });

  int get theNumberOfDoneDays {
    return habit.habitProgress.where((progress) => progress.isDone).length;
  }

  int get theNumberOfDoneDaysInMonth {
    return habit.habitProgress
        .where((progress) =>
            progress.isDone &&
            DateHelper.isSameMonthString(progress.day, chosenMonth))
        .length;
  }

  double get completedPercentByMonth {
    return theNumberOfDoneDaysInMonth / targetDays;
  }

  int get targetDays {
    if (habit.frequency.typeFrequency == EHabitFrequency.weekly.index) {
      return DateTime.now().day;
    } else if (habit.frequency.typeFrequency == EHabitFrequency.daily.index) {
      int targetDays = 0;
      for (int i = 0; i < DateTime.now().day; i++) {
        final weekday = DateTime.now().subtract(Duration(days: i)).weekday;
        if (habit.frequency.dailyDays.contains(
            DateHelper.convertStandardWeekdayToCustomWeekday(weekday))) {
          targetDays++;
        }
      }
      return targetDays;
    }

    throw Exception('TYPE FREQUENCY IS INVALID');
  }

  int get theLongestStreak {
    return findLongestStreak(habit.habitProgress);
  }

  int get theCurrentStreak {
    return findCurrentStreak(habit.habitProgress
        .where((progressItem) =>
            DateHelper.isSameMonthString(progressItem.day, chosenMonth))
        .toList());
  }

  int get theLongestStreakInMonth {
    return findLongestStreak(habit.habitProgress
        .where((progressItem) =>
            DateHelper.isSameMonthString(progressItem.day, chosenMonth))
        .toList());
  }

  int get theCurrentStreakInMonth {
    return findLongestStreak(habit.habitProgress
        .where((progressItem) =>
            DateHelper.isSameMonthString(progressItem.day, chosenMonth))
        .toList());
  }

  List<DiaryItemData> get listDiary {
    //TODO Move to diary bloc
    return habit.habitProgress
        .where((itemProgress) => itemProgress.diary != null)
        .map((itemProgress) => DiaryItemData(
              date: DateTime.parse(itemProgress.day),
              title: habit.name,
              content: itemProgress.diary.text,
              images: itemProgress.diary.images,
            ))
        .toList();
  }

  factory DetailHabitState.loading() => const DetailHabitState(loading: true);

  @override
  List<Object> get props => [
        habit,
        loading,
        chosenDay,
        chosenMonth,
      ];

  DetailHabitState copyWith({
    Habit habit,
    String chosenDay,
    bool loading,
    String chosenMonth,
  }) {
    if ((habit == null || identical(habit, this.habit)) &&
        (chosenDay == null || identical(chosenDay, this.chosenDay)) &&
        (loading == null || identical(loading, this.loading)) &&
        (chosenMonth == null || identical(chosenMonth, this.chosenMonth))) {
      return this;
    }

    return DetailHabitState(
      habit: habit ?? this.habit,
      chosenDay: chosenDay ?? this.chosenDay,
      loading: loading ?? this.loading,
      chosenMonth: chosenMonth ?? this.chosenMonth,
    );
  }

  @override
  String toString() {
    return 'DetailHabitState{habit: $habit, chosenDay: $chosenDay, loading: $loading, chosenMonth: $chosenMonth}';
  }

  int findLongestStreak(List<HabitProgressItem> habitProgress) {
    if (habitProgress.isEmpty) {
      return 0;
    }
    final List<HabitProgressItem> _currentMonthHabitProgress = habitProgress;

    _currentMonthHabitProgress
        .sort((a, b) => DateTime.parse(a.day).compareTo(DateTime.parse(b.day)));

    int longestStreak = 0;
    int currentStreak = 0;

    if (_currentMonthHabitProgress.first.isDone) {
      currentStreak++;
    }

    log("listProgress", _currentMonthHabitProgress);

    for (int i = 1; i < _currentMonthHabitProgress.length; i++) {
      if (_currentMonthHabitProgress[i].isDone) {
        if (currentStreak == 0) {
          currentStreak = 1;
        } else if (isConsecutive(_currentMonthHabitProgress[i].day,
            _currentMonthHabitProgress[i - 1].day)) {
          currentStreak++;
        } else {
          if (currentStreak > longestStreak) {
            longestStreak = currentStreak;
          }
          currentStreak = 1;
        }
      } else {
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
        currentStreak = 0;
      }
      log("currentStreak", "$currentStreak $i");
    }

    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }

    return longestStreak;
  }

  int findCurrentStreak(List<HabitProgressItem> habitProgress) {
    if (habitProgress.isEmpty) {
      return 0;
    }
    List<HabitProgressItem> _currentMonthHabitProgress = habitProgress;

    _currentMonthHabitProgress
        .sort((a, b) => DateTime.parse(a.day).compareTo(DateTime.parse(b.day)));

    _currentMonthHabitProgress = _currentMonthHabitProgress.reversed.toList();

    int currentStreak = 0;

    if (_currentMonthHabitProgress.first.isDone) {
      currentStreak++;
    }

    for (int i = 1; i < _currentMonthHabitProgress.length; i++) {
      if (_currentMonthHabitProgress[i].isDone &&
          isConsecutive(_currentMonthHabitProgress[i - 1].day,
              _currentMonthHabitProgress[i].day)) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  bool isConsecutive(String date, String previousDate) {
    bool isConsecutive = false;
    if (habit.frequency.typeFrequency == EHabitFrequency.weekly.index) {
      isConsecutive =
          DateTime.parse(date).day - DateTime.parse(previousDate).day == 1;
    } else {
      final isWithinWeek =
          DateHelper.isWithinWeekFromString(date, previousDate);
      if (isWithinWeek) {
        final indexCurrentWeekday = habit.frequency.dailyDays
            .indexOf(DateHelper.getCustomWeekdayFromString(date));
        final indexPreviousWeekday = habit.frequency.dailyDays
            .indexOf(DateHelper.getCustomWeekdayFromString(previousDate));

        if (indexCurrentWeekday == 0 &&
            indexPreviousWeekday == (habit.frequency.dailyDays.length - 1)) {
          isConsecutive = true;
        } else if (indexCurrentWeekday > 0 &&
            indexPreviousWeekday >= 0 &&
            indexCurrentWeekday - indexPreviousWeekday == 1) {
          isConsecutive = true;
        }
      }
    }

    return isConsecutive;
  }
}
