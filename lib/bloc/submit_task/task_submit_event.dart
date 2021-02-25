import 'package:equatable/equatable.dart';
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

class TaskSubmitChanged extends TaskSubmitEvent {
  final String taskName;
  final int priority;
  final String taskDate;
  final Project project;
  final List<Label> labels;

  TaskSubmitChanged(
      {this.taskName, this.priority, this.taskDate, this.project, this.labels});

  @override
  List<Object> get props => [taskName, priority, taskDate, project, labels];

  @override
  String toString() {
    return 'TaskAddChanged{taskName: $taskName, priority: $priority, taskDate: $taskDate, projectId: $project, labelIds: $labels}';
  }
}

class HandledSuccessState extends TaskSubmitEvent {}

class SubmitAddTask extends TaskSubmitEvent {}

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
