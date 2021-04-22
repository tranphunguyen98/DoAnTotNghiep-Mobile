import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/habit/diary_item.dart';
import 'package:totodo/data/entity/habit/habit.dart';

abstract class DetailHabitEvent extends Equatable {
  const DetailHabitEvent();

  @override
  List<Object> get props => [];
}

class InitDataDetailHabit extends DetailHabitEvent {
  final Habit habit;

  const InitDataDetailHabit({
    this.habit,
  });

  @override
  List<Object> get props => [habit];

  @override
  String toString() {
    return 'InitDataDetailHabit{habit: $habit}';
  }
}

class CheckInHabit extends DetailHabitEvent {}

class AddDiary extends DetailHabitEvent {
  final DiaryItem item;

  const AddDiary(
    this.item,
  );

  @override
  List<Object> get props => [item];

  @override
  String toString() {
    return 'AddDiary{item: $item}';
  }
}
