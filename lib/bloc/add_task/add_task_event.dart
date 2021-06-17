import 'package:equatable/equatable.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';

abstract class TaskAddEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskAddChanged extends TaskAddEvent {
  final String taskName;
  final int priority;
  final Project project;
  final List<Label> labels;
  final String sectionId;
  final String taskDate;

  TaskAddChanged(
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

class SubmitAddTask extends TaskAddEvent {}

class OnDataTaskAddChanged extends TaskAddEvent {}
