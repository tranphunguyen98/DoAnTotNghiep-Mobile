import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/habit/diary_item.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_progress_item.g.dart';

@HiveType(typeId: kHiveTypeProgressItem)
class HabitProgressItem extends Equatable {
  @HiveField(0)
  final List<DiaryItem> diaries;
  @HiveField(1)
  final int currentCheckInAmounts;
  @HiveField(2)
  final bool isDone;
  @HiveField(3)
  final String day;

  const HabitProgressItem({
    @required this.diaries,
    @required this.currentCheckInAmounts,
    @required this.isDone,
    @required this.day,
  });

  @override
  List<Object> get props => [diaries, currentCheckInAmounts, isDone, day];
}
