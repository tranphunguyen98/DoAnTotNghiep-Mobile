import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';

@immutable
class DetailHabitState extends Equatable {
  final Habit habit;
  final String chosenDay;
  final bool loading;

  const DetailHabitState({
    this.habit,
    this.chosenDay,
    this.loading,
  });

  factory DetailHabitState.loading() => const DetailHabitState(loading: true);

  @override
  List<Object> get props => [
        habit,
        loading,
        chosenDay,
      ];

  DetailHabitState copyWith({
    Habit habit,
    String chosenDay,
    bool loading,
  }) {
    if ((habit == null || identical(habit, this.habit)) &&
        (chosenDay == null || identical(chosenDay, this.chosenDay)) &&
        (loading == null || identical(loading, this.loading))) {
      return this;
    }

    return DetailHabitState(
      habit: habit ?? this.habit,
      chosenDay: chosenDay ?? this.chosenDay,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'DetailHabitState{habit: $habit, chosenDay: $chosenDay, loading: $loading}';
  }
}
