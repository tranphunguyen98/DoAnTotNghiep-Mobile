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

  //TODO handle text
  const HabitIcon({
    this.iconColor,
    this.iconText,
    this.iconImage,
  });

  factory HabitIcon.fromJson(Map<String, dynamic> map) {
    return HabitIcon(
      iconColor: map['iconColor'] as String,
      iconText: map['iconText'] as String,
      iconImage: map['iconImage'] as String,
    );
  }

  HabitIcon copyWith({
    String iconColor,
    String iconText,
    String iconImage,
  }) {
    if ((iconColor == null || identical(iconColor, this.iconColor)) &&
        (iconText == null || identical(iconText, this.iconText)) &&
        (iconImage == null || identical(iconImage, this.iconImage))) {
      return this;
    }

    return HabitIcon(
      iconColor: iconColor ?? this.iconColor,
      iconText: iconText ?? this.iconText,
      iconImage: iconImage ?? this.iconImage,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'iconColor': this.iconColor ?? "",
      'iconText': this.iconText ?? "",
      'iconImage': this.iconImage ?? "",
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props => [iconColor, iconText, iconImage];
}
