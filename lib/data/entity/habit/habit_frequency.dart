import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_frequency.g.dart';

@HiveType(typeId: kHiveTypeHabitFrequency)
class HabitFrequency extends Equatable {
  @HiveField(0)
  //TODO maybe change to String
  final int typeFrequency;
  @HiveField(1)
  final List<int> dailyDays;
  @HiveField(2)
  final int weeklyDays;
  @HiveField(3)
  final int intervalDays;

  const HabitFrequency({
    @required this.typeFrequency,
    this.dailyDays,
    this.weeklyDays,
    this.intervalDays,
  });

  HabitFrequency copyWith({
    int typeFrequency,
    List<int> dailyDays,
    int weeklyDays,
    int intervalDays,
  }) {
    if ((typeFrequency == null ||
            identical(typeFrequency, this.typeFrequency)) &&
        (dailyDays == null || identical(dailyDays, this.dailyDays)) &&
        (weeklyDays == null || identical(weeklyDays, this.weeklyDays)) &&
        (intervalDays == null || identical(intervalDays, this.intervalDays))) {
      return this;
    }

    return new HabitFrequency(
      typeFrequency: typeFrequency ?? this.typeFrequency,
      dailyDays: dailyDays ?? this.dailyDays,
      weeklyDays: weeklyDays ?? this.weeklyDays,
      intervalDays: intervalDays ?? this.intervalDays,
    );
  }

  @override
  List<Object> get props => [
        typeFrequency,
        dailyDays,
        weeklyDays,
        intervalDays,
      ];
}
