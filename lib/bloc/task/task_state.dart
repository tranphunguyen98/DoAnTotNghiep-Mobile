import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/util.dart';

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

  final List<DrawerItemData> drawerItems;
  final int indexDrawerSelected;
  final Task taskAdd;
  final List<Task> _listAllTask;
  final List<Project> listProject;
  final List<Label> listLabel;
  final bool loading;
  final String msg;

  List<Task> listDataDisplay({int projectId, int labelId}) {
    if (_listAllTask == null) return <Task>[];

    if (indexDrawerSelected == kDrawerIndexInbox) {
      return _listAllTask
          .where((element) => element.projectId?.isEmpty ?? true)
          .toList();
    }

    if (indexDrawerSelected == kDrawerIndexToday) {
      return _listAllTask
          .where(
            (element) =>
                !(element.taskDate?.isEmpty ?? true) &&
                Util.isSameDay(
                  DateTime.parse(element.taskDate),
                  DateTime.now(),
                ),
          )
          .toList();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeProject) {
      return _listAllTask.where((element) {
        return element.projectId ==
            (drawerItems[indexDrawerSelected].data as Project).id;
      }).toList();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeLabel) {
      return _listAllTask.where((element) {
        return element.labelId ==
            (drawerItems[indexDrawerSelected].data as Label).id;
      }).toList();
    }

    return <Task>[];
  }

  const DisplayListTasks(
      {this.indexDrawerSelected = kDrawerIndexInbox,
      this.taskAdd = const Task(),
      this.loading,
      this.msg,
      List<Task> listAllTask,
      this.drawerItems,
      this.listProject,
      this.listLabel})
      : _listAllTask = listAllTask;

  factory DisplayListTasks.loading() {
    return DisplayListTasks(loading: true);
  }

  // factory DisplayListTasks.data(List<Task> listAllTask) {
  //   return DisplayListTasks(listAllTask: listAllTask, loading: false);
  // }

  factory DisplayListTasks.error(String msg) {
    return DisplayListTasks(msg: msg, loading: false);
  }

  DisplayListTasks updateTask(Task task) {
    // print("updateTask $task");
    return copyWith(taskAdd: task);
  }

  @override
  List<Object> get props => [
        indexDrawerSelected,
        taskAdd,
        _listAllTask,
        loading,
        msg,
        drawerItems,
        listProject,
        listLabel
      ];

  @override
  String toString() {
    return 'DisplayListTasks: $drawerItems}';
    // return 'DisplayListTasks{taskAdd: $taskAdd, listAllTask: ${_listAllTask?.length ?? "null"}, loading: $loading, msg: $msg}';
  }

  DisplayListTasks copyWith({
    List<DrawerItemData> drawerItems,
    int indexDrawerSelected,
    Task taskAdd,
    List<Task> listAllTask,
    List<Project> listProject,
    List<Label> listLabel,
    bool loading,
    String msg,
  }) {
    if ((drawerItems == null || identical(drawerItems, this.drawerItems)) &&
        (indexDrawerSelected == null ||
            identical(indexDrawerSelected, this.indexDrawerSelected)) &&
        (taskAdd == null || identical(taskAdd, this.taskAdd)) &&
        (listAllTask == null || identical(listAllTask, _listAllTask)) &&
        (listProject == null || identical(listProject, this.listProject)) &&
        (listLabel == null || identical(listLabel, this.listLabel)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return DisplayListTasks(
      drawerItems: drawerItems ?? this.drawerItems,
      indexDrawerSelected: indexDrawerSelected ?? this.indexDrawerSelected,
      taskAdd: taskAdd ?? this.taskAdd,
      listAllTask: listAllTask ?? _listAllTask,
      listProject: listProject ?? this.listProject,
      listLabel: listLabel ?? this.listLabel,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }
}
