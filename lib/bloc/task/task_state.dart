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
  static const kDrawerIndexInbox = 0;
  static const kDrawerIndexToday = 1;
  static const kDrawerIndexNextWeek = 2;
  static const kDrawerIndexThisMonth = 3;

  final int indexDrawerSelected;
  final Task taskAdd;
  final List<Task> _listAllTask;
  final bool loading;
  final String msg;

  List<Task> listDataDisplay({int projectId, int labelId}) {
    if (_listAllTask == null) return <Task>[];

    if (projectId == null && labelId == null) {
      if (indexDrawerSelected == kDrawerIndexInbox) {
        return _listAllTask
            .where((element) =>
                element.projectName == null || element.projectName.isEmpty)
            .toList();
      }
    }

    return <Task>[];
  }

  const DisplayListTasks({
    this.indexDrawerSelected = kDrawerIndexInbox,
    this.taskAdd = const Task(),
    this.loading,
    this.msg,
    List<Task> listAllTask,
  }) : _listAllTask = listAllTask;

  factory DisplayListTasks.loading() {
    return DisplayListTasks(loading: true);
  }

  factory DisplayListTasks.data(List<Task> listAllTask) {
    return DisplayListTasks(listAllTask: listAllTask, loading: false);
  }

  factory DisplayListTasks.error(String msg) {
    return DisplayListTasks(msg: msg, loading: false);
  }

  DisplayListTasks updateTask(Task task) {
    print("updateTask $task");
    return copyWith(taskAdd: task);
  }

  @override
  List<Object> get props =>
      [indexDrawerSelected, taskAdd, _listAllTask, loading, msg];

  @override
  String toString() {
    return 'DisplayListTasks{taskAdd: $taskAdd, listAllTask: ${_listAllTask?.length ?? "null"}, loading: $loading, msg: $msg}';
  }

  DisplayListTasks copyWith({
    bool canAddTask,
    Task taskAdd,
    List<Task> listAllTask,
    bool loading,
    String msg,
  }) {
    if ((taskAdd == null || identical(taskAdd, this.taskAdd)) &&
        (listAllTask == null || identical(listAllTask, _listAllTask)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return DisplayListTasks(
      taskAdd: taskAdd ?? this.taskAdd,
      listAllTask: listAllTask ?? _listAllTask,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }
}
