import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'section.g.dart';

@HiveType(typeId: kHiveTypeSection)
class Section extends Equatable {
  static const String kIdCompleted = 'completed';

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  final bool isShowIfEmpty;
  final List<Task> listTask;
  final bool Function(String date) dateCondition;

  const Section(
      {@required this.id,
      this.name = '',
      this.isShowIfEmpty = true,
      this.listTask = const [],
      this.dateCondition});

  static const Section kSectionToday = Section(
      id: "today",
      name: "Today",
      isShowIfEmpty: false,
      dateCondition: DateHelper.isTodayString);

  static const Section kSectionEmpty = Section(id: null);

  static const Section kSectionTomorrow = Section(
      id: "tomorrow",
      name: "Tomorrow",
      dateCondition: DateHelper.isTomorrowString);

  static const Section kSectionCompleted = Section(
    id: kIdCompleted,
    name: "Completed",
    isShowIfEmpty: false,
  );

  static const Section kSectionOverdue = Section(
      id: "overdue",
      name: "Overdue",
      isShowIfEmpty: false,
      dateCondition: DateHelper.isOverDueString);

  static const Section kSectionNoName =
      Section(id: "noName", isShowIfEmpty: false);

  Section copyWith({
    String id,
    String name,
    bool isShowIfEmpty,
    List<Task> listTask,
    bool Function(String date) dateCondition,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (isShowIfEmpty == null ||
            identical(isShowIfEmpty, this.isShowIfEmpty)) &&
        (listTask == null || identical(listTask, this.listTask)) &&
        (dateCondition == null ||
            identical(dateCondition, this.dateCondition))) {
      return this;
    }

    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      isShowIfEmpty: isShowIfEmpty ?? this.isShowIfEmpty,
      listTask: listTask ?? this.listTask,
      dateCondition: dateCondition ?? this.dateCondition,
    );
  }

  @override
  String toString() {
    return 'Section{id: $id, name: $name}';
  }

  factory Section.fromJson(Map<String, dynamic> map) {
    return Section(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'name': name,
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
