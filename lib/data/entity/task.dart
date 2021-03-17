import 'package:equatable/equatable.dart';

import 'check_item.dart';
import 'label.dart';
import 'project.dart';

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
  final String sectionId;
  final List<Label> labels;
  final List<CheckItem> checkList;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Task(
      {this.id,
      this.createdDate,
      this.updatedDate,
      this.name,
      this.description,
      this.taskDate,
      this.project,
      this.labels,
      this.priorityType = kPriority4,
      this.isCompleted = false,
      this.isStarred = false,
      this.isTrashed = false,
      this.sectionId,
      this.checkList});

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
    String sectionId,
    List<Label> labels,
    List<CheckItem> checkList,
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
        (sectionId == null || identical(sectionId, this.sectionId)) &&
        (labels == null || identical(labels, this.labels)) &&
        (checkList == null || identical(checkList, this.checkList))) {
      return this;
    }

    return Task(
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
      sectionId: sectionId ?? this.sectionId,
      labels: labels ?? this.labels,
      checkList: checkList ?? this.checkList,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, createdDate: $createdDate, updatedDate: $updatedDate, priorityType: $priorityType, name: $name, description: $description, isCompleted: $isCompleted, isStarred: $isStarred, isTrashed: $isTrashed, taskDate: $taskDate, project: $project, sectionId: $sectionId, labels: $labels, checkList: $checkList}';
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
          sectionId == other.sectionId &&
          labels == other.labels &&
          checkList == other.checkList);

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
      sectionId.hashCode ^
      labels.hashCode ^
      checkList.hashCode;

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
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
      sectionId: map['sectionId'] as String,
      labels: map['labels'] as List<Label>,
      checkList: map['checkList'] as List<CheckItem>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'priorityType': priorityType,
      'name': name,
      'description': description,
      'isCompleted': isCompleted,
      'isStarred': isStarred,
      'isTrashed': isTrashed,
      'taskDate': taskDate,
      'project': project,
      'sectionId': sectionId,
      'labels': labels,
      'checkList': checkList,
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
        sectionId,
        checkList,
      ];
}
