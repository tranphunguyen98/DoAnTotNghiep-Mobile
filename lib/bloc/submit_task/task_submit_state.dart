import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/task.dart';

class TaskSubmitState extends Equatable {
  //TODO add task Source to compare with changed task.
  final Task taskSubmit; // Save Task (add or edit)
  final bool loading;
  final String msg;
  final bool success;

  const TaskSubmitState({
    this.taskSubmit = const Task(),
    this.loading = false,
    this.msg,
    this.success = false,
  });
  TaskSubmitState submitSuccess() {
    return copyWith(success: true);
  }

  TaskSubmitState updateTask(Task task) {
    return copyWith(taskSubmit: task);
  }

  @override
  List<Object> get props => [taskSubmit, loading, msg, success];

  TaskSubmitState copyWith({
    Task taskSubmit,
    bool loading,
    String msg,
    bool success,
  }) {
    if ((taskSubmit == null || identical(taskSubmit, this.taskSubmit)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg)) &&
        (success == null || identical(success, this.success))) {
      return this;
    }

    return TaskSubmitState(
      taskSubmit: taskSubmit ?? this.taskSubmit,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
      success: success ?? this.success,
    );
  }

  @override
  String toString() {
    return 'TaskSubmitState{taskSubmit: $taskSubmit, loading: $loading, msg: $msg, success: $success}';
  }
}
