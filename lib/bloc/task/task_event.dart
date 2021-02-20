import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends TaskEvent {}

class TaskChanged extends TaskEvent {
  final Task taskAdd;

  TaskChanged({@required this.taskAdd});

  @override
  List<Object> get props => [taskAdd];

  @override
  String toString() {
    return 'TaskChanged{taskAdd: $taskAdd}';
  }
}

class AddTask extends TaskEvent {}
