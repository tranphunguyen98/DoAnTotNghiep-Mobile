import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'diary_item.g.dart';

@HiveType(typeId: kHiveTypeDiaryItem)
class DiaryItem extends Equatable {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final List<String> images;

  const DiaryItem({
    @required this.text,
    @required this.images,
  });

  @override
  List<Object> get props => [text, images];
}
