import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenScreenHabit extends HabitEvent {}
