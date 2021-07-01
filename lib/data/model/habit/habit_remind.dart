import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_remind.g.dart';

@HiveType(typeId: kHiveTypeHabitRemind)
class HabitRemind extends Equatable {
  @HiveField(0)
  final int hour;
  @HiveField(1)
  final int minute;

  const HabitRemind({
    @required this.hour,
    @required this.minute,
  });

  factory HabitRemind.fromJson(Map<String, dynamic> map) {
    return HabitRemind(
      hour: map['hour'] as int,
      minute: map['minute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'hour': this.hour,
      'minute': this.minute,
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props => [
        hour,
        minute,
      ];
}
