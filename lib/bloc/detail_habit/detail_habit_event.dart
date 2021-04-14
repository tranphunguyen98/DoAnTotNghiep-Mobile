import 'package:equatable/equatable.dart';

abstract class DetailHabitEvent extends Equatable {
  const DetailHabitEvent();

  @override
  List<Object> get props => [];
}

class InitDataStatistic extends DetailHabitEvent {}
