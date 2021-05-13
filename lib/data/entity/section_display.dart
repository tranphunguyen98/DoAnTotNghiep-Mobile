import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'section_display.g.dart';

@HiveType(typeId: kHiveTypeSection)
class SectionDisplay extends Equatable {
  static const String kIdCompleted = 'completed';

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  final String projectId;

  final bool isShowIfEmpty;
  final List<Task> listTask;
  final bool Function(String date) dateCondition;

  const SectionDisplay(
      {@required this.id,
      this.name = '',
      this.isShowIfEmpty = true,
      this.listTask = const [],
      this.projectId,
      this.dateCondition});

  static const SectionDisplay kSectionToday = SectionDisplay(
      id: "today",
      name: "Today",
      isShowIfEmpty: false,
      dateCondition: DateHelper.isTodayString);

  static const SectionDisplay kSectionEmpty = SectionDisplay(id: null);

  static const SectionDisplay kSectionTomorrow = SectionDisplay(
      id: "tomorrow",
      name: "Tomorrow",
      dateCondition: DateHelper.isTomorrowString);

  static const SectionDisplay kSectionCompleted = SectionDisplay(
    id: kIdCompleted,
    name: "Completed",
    isShowIfEmpty: false,
  );

  static const SectionDisplay kSectionOverdue = SectionDisplay(
      id: "overdue",
      name: "Overdue",
      isShowIfEmpty: false,
      dateCondition: DateHelper.isOverDueString);

  static const SectionDisplay kSectionNoName =
      SectionDisplay(id: "noName", isShowIfEmpty: false);

  SectionDisplay copyWith({
    String id,
    String name,
    String projectId,
    bool isShowIfEmpty,
    List<Task> listTask,
    bool Function(String date) dateCondition,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (projectId == null || identical(projectId, this.projectId)) &&
        (isShowIfEmpty == null ||
            identical(isShowIfEmpty, this.isShowIfEmpty)) &&
        (listTask == null || identical(listTask, this.listTask)) &&
        (dateCondition == null ||
            identical(dateCondition, this.dateCondition))) {
      return this;
    }

    return SectionDisplay(
      id: id ?? this.id,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      isShowIfEmpty: isShowIfEmpty ?? this.isShowIfEmpty,
      listTask: listTask ?? this.listTask,
      dateCondition: dateCondition ?? this.dateCondition,
    );
  }

  @override
  String toString() {
    return 'Section{id: $id, name: $name, projectId: $projectId, isShowIfEmpty: $isShowIfEmpty, listTask: $listTask, dateCondition: $dateCondition}';
  }

  factory SectionDisplay.fromMap(Map<String, dynamic> map) {
    return SectionDisplay(
      id: map['_id'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      '_id': id,
      'name': name,
    } as Map<String, dynamic>;
  }

  @override
  List<Object> get props => [
        id,
        name,
        projectId,
      ];
}
