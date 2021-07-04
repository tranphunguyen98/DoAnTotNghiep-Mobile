import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

import '../../../utils/my_const/my_const.dart';

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

  factory HabitImage.fromJson(Map<String, dynamic> map) {
    return HabitImage(
      imgBg: map['imgBg'] as String,
      imgUnCheckIn: map['imgUnCheckIn'] as String,
      imgCheckIn: map['imgCheckIn'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'imgBg': this.imgBg ?? kCheckInColor[1],
      'imgUnCheckIn': this.imgUnCheckIn ?? "1",
      'imgCheckIn': this.imgCheckIn ?? "1",
    } as Map<String, dynamic>;
  }

  HabitImage copyWith({
    String imgBg,
    String imgUnCheckIn,
    String imgCheckIn,
  }) {
    if ((imgBg == null || identical(imgBg, this.imgBg)) &&
        (imgUnCheckIn == null || identical(imgUnCheckIn, this.imgUnCheckIn)) &&
        (imgCheckIn == null || identical(imgCheckIn, this.imgCheckIn))) {
      return this;
    }

    return HabitImage(
      imgBg: imgBg ?? this.imgBg,
      imgUnCheckIn: imgUnCheckIn ?? this.imgUnCheckIn,
      imgCheckIn: imgCheckIn ?? this.imgCheckIn,
    );
  }

  @override
  List<Object> get props => [imgBg, imgUnCheckIn, imgCheckIn];
}
