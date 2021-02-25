import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';

class Task extends Equatable {
  static const int kPriority4 = 4;
  static const int kPriority3 = 3;
  static const int kPriority2 = 2;
  static const int kPriority1 = 1;

  final String id;
  final String createdDate;
  final String updatedDate;
  final int priorityType;
  final String name;
  final String description;
  final bool isCompleted;
  final bool isStarred;
  final bool isTrashed;
  final String taskDate;
  final Project project;
  final List<Label> labels;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Task({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.priorityType = kPriority4,
    this.name,
    this.description,
    this.isCompleted = false,
    this.isStarred = false,
    this.isTrashed = false,
    this.taskDate,
    this.project,
    this.labels = const <Label>[],
  });

  Task copyWith({
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
    Project project,
    List<Label> labels,
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
        (project == null || identical(project, this.project)) &&
        (labels == null || identical(labels, this.labels))) {
      return this;
    }

    return new Task(
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
      project: project ?? this.project,
      labels: labels ?? this.labels,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, createdDate: $createdDate, updatedDate: $updatedDate, priorityType: $priorityType, name: $name, description: $description, isCompleted: $isCompleted, isStarred: $isStarred, isTrashed: $isTrashed, taskDate: $taskDate, project: $project, labels: $labels}';
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
          name == other.name &&
          description == other.description &&
          isCompleted == other.isCompleted &&
          isStarred == other.isStarred &&
          isTrashed == other.isTrashed &&
          taskDate == other.taskDate &&
          project == other.project &&
          labels == other.labels);

  @override
  int get hashCode =>
      id.hashCode ^
      createdDate.hashCode ^
      updatedDate.hashCode ^
      priorityType.hashCode ^
      name.hashCode ^
      description.hashCode ^
      isCompleted.hashCode ^
      isStarred.hashCode ^
      isTrashed.hashCode ^
      taskDate.hashCode ^
      project.hashCode ^
      labels.hashCode;

  factory Task.fromMap(Map<String, dynamic> map) {
    return new Task(
      id: map['id'] as String,
      createdDate: map['createdDate'] as String,
      updatedDate: map['updatedDate'] as String,
      priorityType: map['priorityType'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      isStarred: map['isStarred'] as bool,
      isTrashed: map['isTrashed'] as bool,
      taskDate: map['taskDate'] as String,
      project: map['project'] as Project,
      labels: map['labels'] as List<Label>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'createdDate': this.createdDate,
      'updatedDate': this.updatedDate,
      'priorityType': this.priorityType,
      'name': this.name,
      'description': this.description,
      'isCompleted': this.isCompleted,
      'isStarred': this.isStarred,
      'isTrashed': this.isTrashed,
      'taskDate': this.taskDate,
      'project': this.project,
      'labels': this.labels,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  //TODO add more props
  @override
  List<Object> get props => [
        id,
        // createdDate,
        // updatedDate,
        priorityType,
        taskDate,
        name,
        description,
        isCompleted,
        isStarred,
        isTrashed,
        project,
        labels,
      ];
}
