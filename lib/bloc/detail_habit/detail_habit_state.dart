import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';

@immutable
class DetailHabitState extends Equatable {
  final Habit habit;
  final bool loading;

  const DetailHabitState({
    this.habit,
    this.loading,
  });

  factory DetailHabitState.loading() => const DetailHabitState(loading: true);

  @override
  List<Object> get props => [
        habit,
        loading,
      ];

  DetailHabitState copyWith({
    Habit habit,
    bool loading,
  }) {
    if ((habit == null || identical(habit, this.habit)) &&
        (loading == null || identical(loading, this.loading))) {
      return this;
    }

    return DetailHabitState(
      habit: habit ?? this.habit,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'DetailHabitState{habit: $habit, loading: $loading}';
  }
}
