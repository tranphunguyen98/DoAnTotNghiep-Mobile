import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_image.g.dart';

@HiveType(typeId: kHiveTypeHabitImage)
class HabitImage extends Equatable {
  @HiveField(0)
  final String imgBg;
  @HiveField(1)
  final String imgUnCheckIn;
  @HiveField(2)
  final String imgCheckIn;

  const HabitImage({
    @required this.imgBg,
    @required this.imgUnCheckIn,
    @required this.imgCheckIn,
  });

  @override
  List<Object> get props => [imgBg, imgUnCheckIn, imgCheckIn];
}
