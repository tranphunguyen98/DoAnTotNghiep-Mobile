import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

// class AddTaskState extends TaskState {
//   final Task task;
//   final bool isSubmitting;
//   final bool isSuccess;
//   final String error;
//
//   AddTaskState update({String taskName}) {
//     return copyWith(task: task.copyWith(taskName: taskName));
//   }
//
//   const AddTaskState({
//     this.task = const Task(),
//     this.isSubmitting = false,
//     this.isSuccess = false,
//     this.error,
//   });
//
//   AddTaskState copyWith({
//     Task task,
//     bool isSubmitting,
//     bool isSuccess,
//     String error,
//   }) {
//     if ((task == null || identical(task, this.task)) &&
//         (isSubmitting == null || identical(isSubmitting, this.isSubmitting)) &&
//         (isSuccess == null || identical(isSuccess, this.isSuccess)) &&
//         (error == null || identical(error, this.error))) {
//       return this;
//     }
//
//     return AddTaskState(
//       task: task ?? this.task,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//       isSuccess: isSuccess ?? this.isSuccess,
//       error: error ?? this.error,
//     );
//   }
//
//   @override
//   List<Object> get props => [task, isSubmitting, isSuccess];
//
//   @override
//   String toString() {
//     return 'AddTaskState{task: $task, isSubmitting: $isSubmitting, isSuccess: $isSuccess, error: $error}';
//   }
// }

class DisplayListTasks extends TaskState {
  final bool canAddTask;
  final List<Task> listAllTask;
  final bool loading;
  final String msg;

  const DisplayListTasks({
    this.listAllTask,
    this.loading,
    this.msg,
    this.canAddTask = false ,
  });

  factory DisplayListTasks.loading() {
    return DisplayListTasks(loading: true);
  }

  factory DisplayListTasks.data(List<Task> listAllTask) {
    return DisplayListTasks(listAllTask: listAllTask, loading: false);
  }

  factory DisplayListTasks.error(String msg) {
    return DisplayListTasks(msg: msg, loading: false);
  }

  DisplayListTasks updateCanAddTask({bool canAddTask}) {
    return copyWith(canAddTask: canAddTask);
  }

  @override
  List<Object> get props => [listAllTask, loading, msg, canAddTask];

  @override
  String toString() {
    return 'DisplayListShows{meta: $listAllTask, loading: $loading, msg: $msg, canAddTask: $canAddTask}';
  }

  DisplayListTasks copyWith({
    bool canAddTask,
    List<Task> listAllTask,
    bool loading,
    String msg,
  }) {
    if ((canAddTask == null || identical(canAddTask, this.canAddTask)) &&
        (listAllTask == null || identical(listAllTask, this.listAllTask)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return DisplayListTasks(
      canAddTask: canAddTask ?? this.canAddTask,
      listAllTask: listAllTask ?? this.listAllTask,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }
}
