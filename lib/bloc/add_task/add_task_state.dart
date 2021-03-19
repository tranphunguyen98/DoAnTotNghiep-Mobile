import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/task.dart';

class TaskAddState extends Equatable {
  final Task taskAdd;
  final bool loading;
  final String msg;
  final bool success;

  const TaskAddState({
    this.taskAdd = const Task(),
    this.loading = false,
    this.msg,
    this.success = false,
  });
  TaskAddState submitSuccess() {
    return copyWith(success: true);
  }

  TaskAddState updateTask(Task task) {
    return copyWith(taskSubmit: task);
  }

  @override
  List<Object> get props => [taskAdd, loading, msg, success];

  TaskAddState copyWith({
    Task taskSubmit,
    bool loading,
    String msg,
    bool success,
  }) {
    if ((taskSubmit == null || identical(taskSubmit, this.taskAdd)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg)) &&
        (success == null || identical(success, this.success))) {
      return this;
    }

    return TaskAddState(
      taskAdd: taskSubmit ?? taskAdd,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
      success: success ?? this.success,
    );
  }

  @override
  String toString() {
    return 'TaskAddState{taskSubmit: $taskAdd, loading: $loading, msg: $msg, success: $success}';
  }
}
