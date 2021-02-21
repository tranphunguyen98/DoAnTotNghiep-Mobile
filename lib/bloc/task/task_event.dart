import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends TaskEvent {}

class TaskAddChanged extends TaskEvent {
  final String taskName;
  final int priority;
  final String taskDate;

  TaskAddChanged({this.taskName, this.priority, this.taskDate});

  @override
  List<Object> get props => [taskName, priority, taskDate];

  @override
  String toString() {
    return 'TaskAddChanged{taskName: $taskName, priority: $priority, taskDate: $taskDate}';
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

class AddTask extends TaskEvent {}
