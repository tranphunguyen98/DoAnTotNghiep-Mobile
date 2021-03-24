import 'package:hive/hive.dart';
import 'package:totodo/data/entity/check_item.dart';

part 'local_task.g.dart';

@HiveType(typeId: 5)
class LocalTask {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdDate;
  @HiveField(2)
  final String updatedDate;
  @HiveField(3)
  final int priority;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final bool isCompleted;
  @HiveField(7)
  final bool isStarred;
  @HiveField(8)
  final bool isTrashed;
  @HiveField(9)
  final String dueDate;
  @HiveField(10)
  final String projectId;
  @HiveField(11)
  final List<String> labelIds;
  @HiveField(12)
  final String sectionId;
  @HiveField(13)
  final List<CheckItem> checkList;
  @HiveField(14)
  final String completedDate;
  @HiveField(15)
  final String crontabSchedule; // cron expression - reminder
  @HiveField(16)
  final List<String> preciseSchedules; // precise datetime - reminder

  const LocalTask({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.priority,
    this.name,
    this.description,
    this.isCompleted,
    this.isStarred,
    this.isTrashed,
    this.dueDate,
    this.projectId,
    this.labelIds,
    this.sectionId,
    this.checkList,
    this.completedDate,
    this.crontabSchedule,
    this.preciseSchedules,
  });

  LocalTask copyWith({
    String id,
    String createdDate,
    String updatedDate,
    int priority,
    String name,
    String description,
    bool isCompleted,
    bool isStarred,
    bool isTrashed,
    String dueDate,
    String projectId,
    List<String> labelIds,
    String sectionId,
    List<CheckItem> checkList,
    String completedDate,
    String crontabSchedule,
    List<String> preciseSchedules,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (updatedDate == null || identical(updatedDate, this.updatedDate)) &&
        (priority == null || identical(priority, this.priority)) &&
        (name == null || identical(name, this.name)) &&
        (description == null || identical(description, this.description)) &&
        (isCompleted == null || identical(isCompleted, this.isCompleted)) &&
        (isStarred == null || identical(isStarred, this.isStarred)) &&
        (isTrashed == null || identical(isTrashed, this.isTrashed)) &&
        (dueDate == null || identical(dueDate, this.dueDate)) &&
        (projectId == null || identical(projectId, this.projectId)) &&
        (labelIds == null || identical(labelIds, this.labelIds)) &&
        (sectionId == null || identical(sectionId, this.sectionId)) &&
        (checkList == null || identical(checkList, this.checkList)) &&
        (completedDate == null ||
            identical(completedDate, this.completedDate)) &&
        (crontabSchedule == null ||
            identical(crontabSchedule, this.crontabSchedule)) &&
        (preciseSchedules == null ||
            identical(preciseSchedules, this.preciseSchedules))) {
      return this;
    }

    return LocalTask(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isStarred: isStarred ?? this.isStarred,
      isTrashed: isTrashed ?? this.isTrashed,
      dueDate: dueDate ?? this.dueDate,
      projectId: projectId ?? this.projectId,
      labelIds: labelIds ?? this.labelIds,
      sectionId: sectionId ?? this.sectionId,
      checkList: checkList ?? this.checkList,
      completedDate: completedDate ?? this.completedDate,
      crontabSchedule: crontabSchedule ?? this.crontabSchedule,
      preciseSchedules: preciseSchedules ?? this.preciseSchedules,
    );
  }
}
