import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';

class TaskAddState extends Equatable {
  final Task taskAdd;
  final List<Project> projects;
  final List<Label> labels;
  final bool loading;
  final String msg;
  final bool success;

  const TaskAddState({
    this.taskAdd = const Task(),
    this.projects,
    this.labels,
    this.loading = false,
    this.msg,
    this.success = false,
  });
  TaskAddState submitSuccess() {
    return copyWith(success: true);
  }

  TaskAddState updateTask(Task task) {
    return copyWith(taskAdd: task);
  }

  @override
  List<Object> get props => [taskAdd, loading, msg, success, labels, projects];

  TaskAddState copyWith({
    Task taskAdd,
    List<Project> projects,
    List<Label> labels,
    bool loading,
    String msg,
    bool success,
  }) {
    if ((taskAdd == null || identical(taskAdd, this.taskAdd)) &&
        (projects == null || identical(projects, this.projects)) &&
        (labels == null || identical(labels, this.labels)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg)) &&
        (success == null || identical(success, this.success))) {
      return this;
    }

    return TaskAddState(
      taskAdd: taskAdd ?? this.taskAdd,
      projects: projects ?? this.projects,
      labels: labels ?? this.labels,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
      success: success ?? this.success,
    );
  }

  @override
  String toString() {
    return 'TaskAddState{taskAdd: $taskAdd, projects: $projects, labels: $labels, loading: $loading, msg: $msg, success: $success}';
  }
}
