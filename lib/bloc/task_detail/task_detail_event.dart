import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenScreenEditTask extends TaskDetailEvent {
  final Task task;

  OpenScreenEditTask(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'OpenScreenEdit{task: $task}';
  }
}

class OpenScreenEditTaskWithId extends TaskDetailEvent {
  final String taskId;

  OpenScreenEditTaskWithId(this.taskId);

  @override
  List<Object> get props => [taskId];

  @override
  String toString() {
    return 'OpenScreenEditTaskWithId{taskId: $taskId}';
  }
}

class TaskSubmitDateChanged extends TaskDetailEvent {
  final String taskDate;

  TaskSubmitDateChanged(this.taskDate);

  @override
  List<Object> get props => [taskDate];

  @override
  String toString() {
    return 'TaskSubmitDateChange{taskDate: $taskDate';
  }
}

class UpdateItemCheckList extends TaskDetailEvent {
  final CheckItem checkItem;

  UpdateItemCheckList(this.checkItem);

  @override
  List<Object> get props => [checkItem];

  @override
  String toString() {
    return 'UpdateItemCheckList{task: $checkItem}';
  }
}

class SubmitEditTask extends TaskDetailEvent {
  final Task task;

  SubmitEditTask([this.task]);

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'SubmitEditTask{task: $task}';
  }
}

class DeleteCheckItem extends TaskDetailEvent {
  final String idCheckItem;

  DeleteCheckItem(this.idCheckItem);

  @override
  List<Object> get props => [idCheckItem];

  @override
  String toString() {
    return 'DeleteCheckItem{idCheckItem: $idCheckItem}';
  }
}
