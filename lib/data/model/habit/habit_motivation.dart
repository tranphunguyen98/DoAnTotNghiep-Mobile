import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'habit_motivation.g.dart';

@HiveType(typeId: kHiveTypeHabitMotivation)
class HabitMotivation extends Equatable {
  @HiveField(0)
  final String content;
  @HiveField(1)
  final List<String> images;

  const HabitMotivation({@required this.content, this.images});

  HabitMotivation copyWith({
    String content,
    List<String> images,
  }) {
    if ((content == null || identical(content, this.content)) &&
        (images == null || identical(images, this.images))) {
      return this;
    }

    return HabitMotivation(
      content: content ?? this.content,
      images: images ?? this.images,
    );
  }

  factory HabitMotivation.fromJson(Map<String, dynamic> map) {
    return HabitMotivation(
      content: map['content'] as String,
      images: (map['images'] as List).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'content': this.content ?? "",
      'images': this.images ?? [],
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props => [
        content,
        images,
      ];
}
