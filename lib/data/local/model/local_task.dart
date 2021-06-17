import 'package:hive/hive.dart';
import 'package:totodo/data/model/check_item.dart';
import 'package:totodo/utils/my_const/hive_const.dart';
import 'package:totodo/utils/util.dart';

part 'local_task.g.dart';

@HiveType(typeId: kHiveTypeTask)
class LocalTask {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String updatedAt;
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
  final List<String> preciseSchedules;
  @HiveField(17)
  final bool isCreatedOnLocal;

  // precise datetime - reminder

  const LocalTask({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.priority,
    this.name,
    this.description,
    bool isCompleted,
    bool isStarred,
    bool isTrashed,
    bool isCreatedOnLocal,
    this.preciseSchedules,
    this.dueDate,
    this.projectId,
    this.labelIds,
    this.sectionId,
    this.checkList,
    this.completedDate,
    this.crontabSchedule,
  })  : isTrashed = isTrashed ?? false,
        isCompleted = isCompleted ?? false,
        isStarred = isStarred ?? false,
        isCreatedOnLocal = isCreatedOnLocal ?? false;

  factory LocalTask.fromJson(Map<String, dynamic> map) {
    log("testAsync null", map);
    return LocalTask(
      id: map['_id'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      priority: map['priority'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      isStarred: map['isStarred'] as bool,
      isTrashed: map['isTrashed'] as bool ?? false,
      dueDate: map['dueDate'] as String,
      projectId: map['projectId'] as String,
      labelIds: [],
      //TODO labelIds
      // ((map['labelIds'] ?? []) as List)
      //         ?.map((e) => e as String)
      //         ?.toList() ??
      //     [],
      sectionId: map['sectionId'] as String,
      checkList: [],
      completedDate: map['completedDate'] as String,
      crontabSchedule: map['crontabSchedule'] as String,
      preciseSchedules: [],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'priority': priority,
      'name': name,
      'description': description,
      'isCompleted': isCompleted,
      'isStarred': isStarred,
      'isTrashed': isTrashed,
      'dueDate': dueDate,
      'projectId': projectId,
      'labelIds': labelIds,
      'sectionId': sectionId,
      'checkList': checkList,
      'completedDate': completedDate,
      'crontabSchedule': crontabSchedule,
      'preciseSchedules': preciseSchedules,
    } as Map<String, dynamic>;
  }

  LocalTask copyWith({
    String id,
    String createdAt,
    String updatedAt,
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
    bool isOnlyCreatedOnLocal,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt)) &&
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
            identical(preciseSchedules, this.preciseSchedules)) &&
        (isOnlyCreatedOnLocal == null ||
            identical(isOnlyCreatedOnLocal, this.isCreatedOnLocal))) {
      return this;
    }

    return LocalTask(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      isCreatedOnLocal: isOnlyCreatedOnLocal ?? this.isCreatedOnLocal,
    );
  }

  @override
  String toString() {
    return 'LocalTask{id: $id, name: $name, updatedAt: $updatedAt';
    return 'LocalTask{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt,'
        ' priority: $priority, description: $description, isCompleted: $isCompleted,'
        ' isStarred: $isStarred, isTrashed: $isTrashed, dueDate: $dueDate, projectId: $projectId,'
        ' labelIds: $labelIds, sectionId: $sectionId, checkList: $checkList, completedDate: $completedDate,'
        ' crontabSchedule: $crontabSchedule, preciseSchedules: $preciseSchedules, isLocal: $isCreatedOnLocal}';
  }
}
