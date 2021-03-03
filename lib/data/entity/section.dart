import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/util.dart';

part 'section.g.dart';

@HiveType(typeId: 7)
class Section extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  final bool isShowIfEmpty;
  final List<Task> listTask;
  final bool Function(String date) checkDate;

  static const Section kSectionToday = Section(
      id: "today",
      name: "Today",
      isShowIfEmpty: false,
      checkDate: Util.isTodayString);

  static const Section kSectionTomorrow = Section(
      id: "tomorrow", name: "Tomorrow", checkDate: Util.isTomorrowString);

  static const Section kSectionOverdue = Section(
      id: "overdue",
      name: "Overdue",
      isShowIfEmpty: false,
      checkDate: Util.isOverDueString);

  static const Section kSectionNoName = Section(id: "noName", name: "");

  const Section(
      {@required this.id,
      @required this.name,
      this.isShowIfEmpty = true,
      this.listTask = const [],
      this.checkDate});

  Section copyWith({
    String id,
    String name,
    bool isShowIfEmpty,
    List<Task> listTask,
    bool Function(String date) checkDate,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (isShowIfEmpty == null ||
            identical(isShowIfEmpty, this.isShowIfEmpty)) &&
        (listTask == null || identical(listTask, this.listTask)) &&
        (checkDate == null || identical(checkDate, this.checkDate))) {
      return this;
    }

    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      isShowIfEmpty: isShowIfEmpty ?? this.isShowIfEmpty,
      listTask: listTask ?? this.listTask,
      checkDate: checkDate ?? this.checkDate,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
