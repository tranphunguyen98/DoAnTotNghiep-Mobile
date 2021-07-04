import 'package:equatable/equatable.dart';

import 'check_item.dart';
import 'label.dart';
import 'project.dart';

class Task extends Equatable {
  static const int kPriority4 = 4;
  static const int kPriority3 = 3;
  static const int kPriority2 = 2;
  static const int kPriority1 = 1; //most importance

  final String id;
  final String createdAt;
  final String updatedAt;
  final int priority;
  final String name;
  final String description;
  final bool isCompleted;
  final bool isStarred;
  final bool isTrashed;
  final String dueDate;
  final Project project;
  final String sectionId;
  final List<Label> labels;
  final List<CheckItem> checkList;
  final String completedDate;
  final String crontabSchedule; // cron expression - reminder
  final List<String> attachmentInfos; // precise datetime - reminder
  final bool isCreatedOnLocal;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Task(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.description,
      this.dueDate,
      this.project,
      this.labels = const [],
      this.priority = kPriority4,
      this.isCompleted = false,
      this.isStarred = false,
      this.isTrashed = false,
      this.isCreatedOnLocal = false,
      this.sectionId,
      this.checkList = const [],
      this.completedDate,
      this.attachmentInfos,
      this.crontabSchedule});

  Task copyWith({
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
    Project project,
    String sectionId,
    List<Label> labels,
    List<CheckItem> checkList,
    String completedDate,
    String crontabSchedule,
    List<String> attachmentInfos,
    bool isCreatedOnLocal,
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
        (project == null || identical(project, this.project)) &&
        (sectionId == null || identical(sectionId, this.sectionId)) &&
        (labels == null || identical(labels, this.labels)) &&
        (checkList == null || identical(checkList, this.checkList)) &&
        (completedDate == null ||
            identical(completedDate, this.completedDate)) &&
        (crontabSchedule == null ||
            identical(crontabSchedule, this.crontabSchedule)) &&
        (isCreatedOnLocal == null ||
            identical(isCreatedOnLocal, this.isCreatedOnLocal)) &&
        (attachmentInfos == null ||
            identical(attachmentInfos, this.attachmentInfos))) {
      return this;
    }

    return Task(
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
      project: project ?? this.project,
      sectionId: sectionId ?? this.sectionId,
      labels: labels ?? this.labels,
      checkList: checkList ?? this.checkList,
      completedDate: completedDate ?? this.completedDate,
      crontabSchedule: crontabSchedule ?? this.crontabSchedule,
      attachmentInfos: attachmentInfos ?? this.attachmentInfos,
      isCreatedOnLocal: isCreatedOnLocal ?? this.isCreatedOnLocal,
    );
  }

  @override
  String toString() {
    return 'Task{id: $id,'
            // ' createdAt: $createdAt,'
            // ' updatedAt: $updatedAt, '
            // 'priority: $priority,'
            ' name: $name,'
            // ' description: $description,'
            ' isCompleted: $isCompleted,'
            // ' isTrashed: $isTrashed,'
            ' completedDate:$completedDate,'
            ' taskDate: $dueDate,'
        // ' project: ${project?.name},'
        // ' sectionId: $sectionId, labels: $labels,'
        ;
    // ' checkList: $checkList, completedDate: $completedDate,'
    // ' crontabSchedule: $crontabSchedule,'
    // ' attachmentInfos: $attachmentInfos,'
  }

  // factory Task.fromJson(Map<String, dynamic> map) {
  //   return Task(
  //     id: map['_id'] as String,
  //     createdAt: map['createdAt'] as String,
  //     updatedAt: map['updatedAt'] as String,
  //     priority: map['priority'] as int,
  //     name: map['name'] as String,
  //     description: map['description'] as String,
  //     isCompleted: map['isCompleted'] as bool,
  //     isStarred: map['isStarred'] as bool,
  //     isTrashed: map['isTrashed'] as bool,
  //     taskDate: map['taskDate'] as String,
  //     project: map['project'] as Project,
  //     sectionId: map['sectionId'] as String,
  //     labels: map['labels'] as List<Label>,
  //     checkList: map['checkList'] as List<CheckItem>,
  //     completedDate: map['completedDate'] as String,
  //     crontabSchedule: map['crontabSchedule'] as String,
  //     attachmentInfos: map['attachmentInfos'] as List<String>,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   // ignore: unnecessary_cast
  //   return {
  //     '_id': id,
  //     'createdAt': createdAt,
  //     'updatedAt': updatedAt,
  //     'priority': priority,
  //     'name': name,
  //     'description': description,
  //     'isCompleted': isCompleted,
  //     'isStarred': isStarred,
  //     'taskDate': taskDate,
  //     'project': project,
  //     'sectionId': sectionId,
  //     'labels': labels,
  //     'checkList': checkList,
  //     'completedDate': completedDate,
  //     'crontabSchedule': crontabSchedule,
  //     'attachmentInfos': attachmentInfos,
  //   } as Map<String, dynamic>;
  // }

  //</editor-fold>

  //TODO add more props
  @override
  List<Object> get props => [
        id,
        checkList,
        createdAt,
        updatedAt,
        priority,
        dueDate,
        name,
        description,
        isCompleted,
        isStarred,
        isTrashed,
        project,
        labels,
        sectionId,
        completedDate,
        crontabSchedule,
        attachmentInfos,
        isCreatedOnLocal,
      ];
}
