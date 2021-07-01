import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'diary_item.g.dart';

@HiveType(typeId: kHiveTypeDiaryItem)
class Diary extends Equatable {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final List<String> images;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final int feeling;
  @HiveField(4)
  final String time;
  @HiveField(5)
  final String habit;
  @HiveField(6)
  final String createdAt;
  @HiveField(7)
  final String updatedAt;

  const Diary({
    @required this.text,
    this.images,
    this.id,
    this.feeling = 1,
    this.time,
    this.habit,
    this.createdAt,
    this.updatedAt,
  });

  Diary copyWith({
    String text,
    List<String> images,
    String id,
    int feeling,
    String time,
    String habit,
    String createdAt,
    String updatedAt,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (images == null || identical(images, this.images)) &&
        (id == null || identical(id, this.id)) &&
        (feeling == null || identical(feeling, this.feeling)) &&
        (time == null || identical(time, this.time)) &&
        (habit == null || identical(habit, this.habit)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt))) {
      return this;
    }

    return Diary(
      text: text ?? this.text,
      images: images ?? this.images,
      id: id ?? this.id,
      feeling: feeling ?? this.feeling,
      time: time ?? this.time,
      habit: habit ?? this.habit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Diary.fromJson(Map<String, dynamic> map) {
    return Diary(
      text: map['text'] as String,
      images: (map['images'] as List).map((e) => e as String).toList(),
      id: map['_id'] as String,
      feeling: map['feeling'] as int,
      time: map['time'] as String,
      habit: map['habit'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'text': this.text,
      'images': this.images,
      '_id': this.id,
      'feeling': this.feeling,
      'time': this.time,
      'habit': this.habit,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props =>
      [text, images, id, feeling, time, habit, createdAt, updatedAt];
}
