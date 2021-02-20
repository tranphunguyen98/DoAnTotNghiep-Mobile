import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends TaskEvent {}

class CanAddTaskChanged extends TaskEvent {
  final bool canAddTask;

  CanAddTaskChanged({@required this.canAddTask});

  @override
  List<Object> get props => [canAddTask];

  @override
  String toString() {
    return 'CanAddTask{canAddTask: $canAddTask}';
  }
}

class AddTask extends TaskEvent {
  final Task task;

  AddTask({@required this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'AddTask{task: $task}';
  }
}
