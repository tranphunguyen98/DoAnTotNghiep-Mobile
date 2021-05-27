import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_motivation.g.dart';

@HiveType(typeId: kHiveTypeHabitMotivation)
class HabitMotivation extends Equatable {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final List<String> images;

  const HabitMotivation({@required this.text, this.images});

  HabitMotivation copyWith({
    String text,
    List<String> images,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (images == null || identical(images, this.images))) {
      return this;
    }

    return HabitMotivation(
      text: text ?? this.text,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        text,
        images,
      ];
}
