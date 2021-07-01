import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/model/habit/habit.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class InitDataDiary extends DiaryEvent {
  final String habitId;

  const InitDataDiary({this.habitId});

  @override
  List<Object> get props => [habitId];

  @override
  String toString() {
    return 'InitDataDiary{diaries: $habitId}';
  }
}

class FilterChanged extends DiaryEvent {
  final int dateFilter;
  final Habit habitFilter;

  const FilterChanged({
    @required this.dateFilter,
    @required this.habitFilter,
  });

  @override
  List<Object> get props => [dateFilter, habitFilter];

  @override
  String toString() {
    return 'FilterChanged{dateFilter: $dateFilter, habitFilter: $habitFilter}';
  }
}
