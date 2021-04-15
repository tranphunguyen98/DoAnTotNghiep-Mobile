import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/hive_const.dart';

part 'section.g.dart';

@HiveType(typeId: kHiveTypeSection)
class Section extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String projectId;

  final bool isShowIfEmpty;
  final List<Task> listTask;
  final bool Function(String date) condition;

  const Section(
      {@required this.id,
      this.name = '',
      this.isShowIfEmpty = true,
      this.listTask = const [],
      this.projectId,
      this.condition});

  static const Section kSectionToday = Section(
      id: "today",
      name: "Today",
      isShowIfEmpty: false,
      condition: DateHelper.isTodayString);

  static const Section kSectionEmpty = Section(id: null);

  static const Section kSectionTomorrow = Section(
      id: "tomorrow", name: "Tomorrow", condition: DateHelper.isTomorrowString);

  static const Section kSectionOverdue = Section(
      id: "overdue",
      name: "Overdue",
      isShowIfEmpty: false,
      condition: DateHelper.isOverDueString);

  static const Section kSectionNoName = Section(id: "noName");

  Section copyWith({
    String id,
    String name,
    String projectId,
    bool isShowIfEmpty,
    List<Task> listTask,
    bool Function(String date) condition,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (projectId == null || identical(projectId, this.projectId)) &&
        (isShowIfEmpty == null ||
            identical(isShowIfEmpty, this.isShowIfEmpty)) &&
        (listTask == null || identical(listTask, this.listTask)) &&
        (condition == null || identical(condition, this.condition))) {
      return this;
    }

    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      isShowIfEmpty: isShowIfEmpty ?? this.isShowIfEmpty,
      listTask: listTask ?? this.listTask,
      condition: condition ?? this.condition,
    );
  }

  @override
  String toString() {
    return 'Section{id: $id, name: $name, projectId: $projectId}';
  }

  @override
  List<Object> get props => [
        id,
        name,
        projectId,
      ];
}
