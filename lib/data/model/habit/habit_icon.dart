import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_icon.g.dart';

@HiveType(typeId: kHiveTypeHabitIcon)
class HabitIcon extends Equatable {
  @HiveField(0)
  final String iconColor;
  @HiveField(1)
  final String iconText;
  @HiveField(2)
  final String iconImage;

  const HabitIcon({
    this.iconColor,
    this.iconText,
    this.iconImage,
  });

  @override
  List<Object> get props => [iconColor, iconText, iconImage];
}
