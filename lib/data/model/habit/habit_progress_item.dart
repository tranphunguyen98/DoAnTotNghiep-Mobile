import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_progress_item.g.dart';

@HiveType(typeId: kHiveTypeProgressItem)
class HabitProgressItem extends Equatable {
  @HiveField(0)
  final int current;
  @HiveField(1)
  final bool isDone;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String id;

  const HabitProgressItem({
    this.id,
    this.current = 0,
    this.isDone = false,
    @required this.date,
  });

  factory HabitProgressItem.fromJson(Map<String, dynamic> map) {
    return HabitProgressItem(
      // diary: map['diary'] as DiaryItem,
      current: map['current'] as int,
      isDone: map['isDone'] as bool ?? false,
      date: map['date'] as String,
      id: map['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      // 'diary': this.diary,
      'current': this.current,
      'isDone': this.isDone,
      'date': this.date,
      '_id': this.id,
    } as Map<String, dynamic>;
  }

  HabitProgressItem copyWith({
    int current,
    bool isDone,
    String date,
    String id,
  }) {
    if ((current == null || identical(current, this.current)) &&
        (isDone == null || identical(isDone, this.isDone)) &&
        (date == null || identical(date, this.date)) &&
        (id == null || identical(id, this.id))) {
      return this;
    }

    return HabitProgressItem(
      current: current ?? this.current,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [current, isDone, date];
}
