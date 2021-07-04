import 'package:equatable/equatable.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';

abstract class DetailHabitEvent extends Equatable {
  const DetailHabitEvent();

  @override
  List<Object> get props => [];
}

class InitDataDetailHabit extends DetailHabitEvent {
  final Habit habit;
  final String chosenDay;
  const InitDataDetailHabit({
    this.habit,
    this.chosenDay,
  });

  @override
  List<Object> get props => [habit, chosenDay];

  @override
  String toString() {
    return 'InitDataDetailHabit{habit: $habit, chosenDay: $chosenDay}';
  }
}

class CheckInHabit extends DetailHabitEvent {
  final int checkIn;
  const CheckInHabit([this.checkIn]);

  @override
  List<Object> get props => [checkIn];
}

class AddDiary extends DetailHabitEvent {
  final Diary item;
  final String date;

  const AddDiary(this.item, this.date);

  @override
  List<Object> get props => [item, date];

  @override
  String toString() {
    return 'AddDiary{item: $item, date: $date}';
  }
}

class DeleteHabit extends DetailHabitEvent {}

class ArchiveHabit extends DetailHabitEvent {}

class UpdateDataDetailHabit extends DetailHabitEvent {}

class ChosenDayChanged extends DetailHabitEvent {
  final String chosenDay;

  const ChosenDayChanged({
    this.chosenDay,
  });

  @override
  List<Object> get props => [chosenDay];

  @override
  String toString() {
    return 'ChosenDayChanged{chosenDay: $chosenDay}';
  }
}
