import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable {
  static const int kPriority4 = 4;
  static const int kPriority3 = 3;
  static const int kPriority2 = 2;
  static const int kPriority1 = 1;
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String createdDate;
  @HiveField(2)
  final String updatedDate;
  @HiveField(3)
  final int priorityType;
  @HiveField(4)
  final String taskName;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final String projectName;
  @HiveField(7)
  final bool isCompleted;
  @HiveField(8)
  final bool isStarred;
  @HiveField(9)
  final bool isTrashed;

  const Task({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.priorityType = kPriority4,
    this.taskName = "",
    this.description = "",
    this.projectName = "",
    this.isCompleted = false,
    this.isStarred = false,
    this.isTrashed = false,
  });

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      createdDate: map['createdDate'] as String,
      updatedDate: map['updatedDate'] as String,
      priorityType: map['priorityType'] as int,
      taskName: map['taskName'] as String,
      description: map['description'] as String,
      projectName: map['projectName'] as String,
      isCompleted: map['isCompleted'] as bool,
      isStarred: map['isStarred'] as bool,
      isTrashed: map['isTrashed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'createdDate': this.createdDate,
      'updatedDate': this.updatedDate,
      'priorityType': this.priorityType,
      'taskName': this.taskName,
      'description': this.description,
      'projectName': this.projectName,
      'isCompleted': this.isCompleted,
      'isStarred': this.isStarred,
      'isTrashed': this.isTrashed,
    };
  }

  Task copyWith({
    int id,
    String createdDate,
    String updatedDate,
    int priorityType,
    String taskName,
    String description,
    String projectName,
    bool isCompleted,
    bool isStarred,
    bool isTrashed,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (updatedDate == null || identical(updatedDate, this.updatedDate)) &&
        (priorityType == null || identical(priorityType, this.priorityType)) &&
        (taskName == null || identical(taskName, this.taskName)) &&
        (description == null || identical(description, this.description)) &&
        (projectName == null || identical(projectName, this.projectName)) &&
        (isCompleted == null || identical(isCompleted, this.isCompleted)) &&
        (isStarred == null || identical(isStarred, this.isStarred)) &&
        (isTrashed == null || identical(isTrashed, this.isTrashed))) {
      return this;
    }

    return Task(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      priorityType: priorityType ?? this.priorityType,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      projectName: projectName ?? this.projectName,
      isCompleted: isCompleted ?? this.isCompleted,
      isStarred: isStarred ?? this.isStarred,
      isTrashed: isTrashed ?? this.isTrashed,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, taskName: $taskName projectName: $projectName, isCompleted: $isCompleted}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdDate == other.createdDate &&
          updatedDate == other.updatedDate &&
          priorityType == other.priorityType &&
          taskName == other.taskName &&
          description == other.description &&
          projectName == other.projectName &&
          isCompleted == other.isCompleted &&
          isStarred == other.isStarred &&
          isTrashed == other.isTrashed);

  @override
  int get hashCode =>
      id.hashCode ^
      createdDate.hashCode ^
      updatedDate.hashCode ^
      priorityType.hashCode ^
      taskName.hashCode ^
      description.hashCode ^
      projectName.hashCode ^
      isCompleted.hashCode ^
      isStarred.hashCode ^
      isTrashed.hashCode;

  @override
  List<Object> get props => [id, taskName];
}
