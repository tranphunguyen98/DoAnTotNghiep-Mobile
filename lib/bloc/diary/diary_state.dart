import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';

@immutable
class DiaryState extends Equatable {
  static const kFilterDateNoDate = 0;
  static const kFilterDateThisWeek = 1;
  static const kFilterDateThisMonth = 2;
  static const kFilterDateThisYear = 3;

  final List<DiaryItemData> diaries;
  final int dateFilter;
  final Habit habitFilter;
  final List<Habit> habits;
  final String msg;
  final bool isSuccess;

  const DiaryState({
    List<DiaryItemData> diaries,
    this.dateFilter = kFilterDateNoDate,
    this.habitFilter,
    this.msg,
    this.isSuccess = false,
    this.habits,
  }) : diaries = diaries ?? const [];

  factory DiaryState.success() {
    return const DiaryState(isSuccess: true);
  }

  DiaryState copyWith({
    List<DiaryItemData> diaries,
    int dateFilter,
    Habit habitFilter,
    List<Habit> habits,
    String msg,
    bool isSuccess,
  }) {
    if ((diaries == null || identical(diaries, this.diaries)) &&
        (dateFilter == null || identical(dateFilter, this.dateFilter)) &&
        (habitFilter == null || identical(habitFilter, this.habitFilter)) &&
        (habits == null || identical(habits, this.habits)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess))) {
      return this;
    }

    return DiaryState(
      diaries: diaries ?? this.diaries,
      dateFilter: dateFilter ?? this.dateFilter,
      habitFilter: habitFilter ?? this.habitFilter,
      habits: habits ?? this.habits,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  DiaryState setHabitFilterNull() {
    return DiaryState(
      diaries: this.diaries,
      dateFilter: this.dateFilter,
      habits: this.habits,
      msg: this.msg,
      isSuccess: this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'DiaryState{diaries: $diaries, dateFilter: $dateFilter, habitFilter: $habitFilter, habits: $habits, msg: $msg, isSuccess: $isSuccess}';
  }

  @override
  List<Object> get props =>
      [diaries, msg, isSuccess, dateFilter, habitFilter, habits];
}
