import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends TaskEvent {}

class OpenBottomSheetAddTask extends TaskEvent {}

class TaskAddChanged extends TaskEvent {
  final String taskName;
  final int priority;
  final String taskDate;
  final Project project;

  TaskAddChanged({this.taskName, this.priority, this.taskDate, this.project});

  @override
  List<Object> get props => [taskName, priority, taskDate, project];

  @override
  String toString() {
    return 'TaskAddChanged{taskName: $taskName, priority: $priority, taskDate: $taskDate, project: $project}';
  }
}

class TaskUpdated extends TaskEvent {
  final Task task;

  TaskUpdated({@required this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'TaskUpdated{task: $task}';
  }
}

class SelectedDrawerIndexChanged extends TaskEvent {
  final int index;
  final int type;
  final int id;

  SelectedDrawerIndexChanged({this.index, this.type, this.id});

  @override
  List<Object> get props => [index, type, id];

  @override
  String toString() {
    return 'SelectedDrawerIndexChanged{index: $index, type: $type, id: $id}';
  }
}

class AddTask extends TaskEvent {}
