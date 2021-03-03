import 'package:hive/hive.dart';

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
  final int priorityType;
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
  final String taskDate;
  @HiveField(10)
  final String projectId;
  @HiveField(11)
  final List<String> labelIds;
  @HiveField(12)
  final String sectionId;

  const LocalTask({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.priorityType,
    this.name,
    this.description,
    this.isCompleted,
    this.isStarred,
    this.isTrashed,
    this.taskDate,
    this.projectId,
    this.labelIds,
    this.sectionId,
  });

  LocalTask copyWith({
    String id,
    String createdDate,
    String updatedDate,
    int priorityType,
    String name,
    String description,
    bool isCompleted,
    bool isStarred,
    bool isTrashed,
    String taskDate,
    String projectId,
    List<String> labelIds,
    String sectionId,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (updatedDate == null || identical(updatedDate, this.updatedDate)) &&
        (priorityType == null || identical(priorityType, this.priorityType)) &&
        (name == null || identical(name, this.name)) &&
        (description == null || identical(description, this.description)) &&
        (isCompleted == null || identical(isCompleted, this.isCompleted)) &&
        (isStarred == null || identical(isStarred, this.isStarred)) &&
        (isTrashed == null || identical(isTrashed, this.isTrashed)) &&
        (taskDate == null || identical(taskDate, this.taskDate)) &&
        (projectId == null || identical(projectId, this.projectId)) &&
        (labelIds == null || identical(labelIds, this.labelIds)) &&
        (sectionId == null || identical(sectionId, this.sectionId))) {
      return this;
    }

    return LocalTask(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      priorityType: priorityType ?? this.priorityType,
      name: name ?? this.name,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isStarred: isStarred ?? this.isStarred,
      isTrashed: isTrashed ?? this.isTrashed,
      taskDate: taskDate ?? this.taskDate,
      projectId: projectId ?? this.projectId,
      labelIds: labelIds ?? this.labelIds,
      sectionId: sectionId ?? this.sectionId,
    );
  }
}
