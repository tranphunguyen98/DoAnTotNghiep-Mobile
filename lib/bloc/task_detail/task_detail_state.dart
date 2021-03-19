import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/task.dart';

class TaskDetailState extends Equatable {
  //TODO add task Source to compare with changed task.
  final Task taskEdit; // Save Task (add or edit)
  final bool loading;
  final String msg;

  const TaskDetailState({
    this.taskEdit = const Task(),
    this.loading = false,
    this.msg,
  });

  TaskDetailState updateTask(Task task) {
    return copyWith(taskEdit: task);
  }

  @override
  List<Object> get props => [taskEdit, loading, msg];

  TaskDetailState copyWith({
    Task taskEdit,
    bool loading,
    String msg,
  }) {
    if ((taskEdit == null || identical(taskEdit, this.taskEdit)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return TaskDetailState(
      taskEdit: taskEdit ?? this.taskEdit,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }

  @override
  String toString() {
    return 'TaskSubmitState{taskEdit: $taskEdit, loading: $loading, msg: $msg}';
  }
}
