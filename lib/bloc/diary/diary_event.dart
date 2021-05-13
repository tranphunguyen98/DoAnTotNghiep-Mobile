import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class InitDataDiary extends DiaryEvent {
  final List<DiaryItemData> diaries;

  const InitDataDiary({this.diaries});

  @override
  List<Object> get props => [diaries];

  @override
  String toString() {
    return 'InitDataDiary{diaries: $diaries}';
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
