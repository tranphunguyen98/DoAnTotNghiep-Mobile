import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/habit/diary_item.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_progress_item.g.dart';

@HiveType(typeId: kHiveTypeProgressItem)
class HabitProgressItem extends Equatable {
  @HiveField(0)
  final DiaryItem diary; // TODO
  @HiveField(1)
  final int currentCheckInAmounts;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  final String day;

  const HabitProgressItem({
    this.diary,
    this.currentCheckInAmounts = 0,
    this.isDone = false,
    @required this.day,
  });

  HabitProgressItem copyWith({
    DiaryItem diary,
    int currentCheckInAmounts,
    bool isDone,
    String day,
  }) {
    if ((diary == null || identical(diary, this.diary)) &&
        (currentCheckInAmounts == null ||
            identical(currentCheckInAmounts, this.currentCheckInAmounts)) &&
        (isDone == null || identical(isDone, this.isDone)) &&
        (day == null || identical(day, this.day))) {
      return this;
    }

    return HabitProgressItem(
      diary: diary ?? this.diary,
      currentCheckInAmounts:
          currentCheckInAmounts ?? this.currentCheckInAmounts,
      isDone: isDone ?? this.isDone,
      day: day ?? this.day,
    );
  }

  @override
  List<Object> get props => [diary, currentCheckInAmounts, isDone, day];
}
