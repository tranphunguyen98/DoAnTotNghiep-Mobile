import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskSubmitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenBottomSheetAddTask extends TaskSubmitEvent {}

class OpenScreenEditTask extends TaskSubmitEvent {
  final Task task;

  OpenScreenEditTask(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'OpenScreenEdit{task: $task}';
  }
}

class OpenScreenEditTaskWithId extends TaskSubmitEvent {
  final String taskId;

  OpenScreenEditTaskWithId(this.taskId);

  @override
  List<Object> get props => [taskId];

  @override
  String toString() {
    return 'OpenScreenEditTaskWithId{taskId: $taskId}';
  }
}

class TaskSubmitDateChanged extends TaskSubmitEvent {
  final String taskDate;

  TaskSubmitDateChanged(this.taskDate);

  @override
  List<Object> get props => [taskDate];

  @override
  String toString() {
    return 'TaskSubmitDateChange{taskDate: $taskDate';
  }
}

class TaskSubmitChanged extends TaskSubmitEvent {
  final String taskName;
  final int priority;
  final Project project;
  final List<Label> labels;
  final String sectionId;
  final String taskDate;

  TaskSubmitChanged(
      {this.taskName,
      this.priority,
      this.project,
      this.labels,
      this.taskDate,
      this.sectionId});

  @override
  List<Object> get props =>
      [taskName, priority, project, labels, sectionId, taskDate];

  @override
  String toString() {
    return 'TaskAddChanged{taskName: $taskName, priority: $priority, projectId: $project, labelIds: $labels, sectionId: $sectionId, taskDate: $taskDate}';
  }
}

class HandledSuccessState extends TaskSubmitEvent {}

class SubmitAddTask extends TaskSubmitEvent {}

class UpdateItemCheckList extends TaskSubmitEvent {
  final CheckItem checkItem;

  UpdateItemCheckList(this.checkItem);

  @override
  List<Object> get props => [checkItem];

  @override
  String toString() {
    return 'UpdateItemCheckList{task: $checkItem}';
  }
}

class SubmitEditTask extends TaskSubmitEvent {
  final Task task;

  SubmitEditTask([this.task]);

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'UpdateTask{task: $task}';
  }
}

class DeleteCheckItem extends TaskSubmitEvent {
  final String idCheckItem;

  DeleteCheckItem(this.idCheckItem);

  @override
  List<Object> get props => [idCheckItem];

  @override
  String toString() {
    return 'DeleteCheckItem{idCheckItem: $idCheckItem}';
  }
}
