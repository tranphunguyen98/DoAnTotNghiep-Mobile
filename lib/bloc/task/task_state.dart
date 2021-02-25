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

class DisplayListTasks extends TaskState {
  static const kDrawerIndexInbox = 0;
  static const kDrawerIndexToday = 1;
  static const kDrawerIndexNextWeek = 2;
  static const kDrawerIndexThisMonth = 3;

  final List<DrawerItemData> drawerItems;
  final int indexDrawerSelected;
  final List<Task> _listAllTask;
  final List<Project> listProject;
  final List<Label> listLabel;
  final bool loading;
  final String msg;

  List<Task> listDataDisplay({int projectId, int labelId}) {
    if (_listAllTask == null) return <Task>[];

    if (indexDrawerSelected == kDrawerIndexInbox) {
      return _listAllTask
          .where((element) => element.project?.id?.isEmpty ?? true)
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
        if (element.project == null) {
          return false;
        }
        return element.project?.id ==
            (drawerItems[indexDrawerSelected].data as Project).id;
      }).toList();
    }

    if (drawerItems[indexDrawerSelected].type == DrawerItemData.kTypeLabel) {
      return _listAllTask.where((element) {
        if (element.labels?.isEmpty ?? true) {
          return false;
        }

        return element.labels
            .contains(drawerItems[indexDrawerSelected].data as Label);
      }).toList();
    }

    return <Task>[];
  }

  const DisplayListTasks(
      {this.indexDrawerSelected = kDrawerIndexInbox,
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

  factory DisplayListTasks.error(String msg) {
    return DisplayListTasks(msg: msg, loading: false);
  }

  @override
  List<Object> get props => [
        indexDrawerSelected,
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
    // return 'DisplayListTasks{taskSubmit: $taskSubmit, listAllTask: ${_listAllTask?.length ?? "null"}, loading: $loading, msg: $msg}';
  }

  DisplayListTasks copyWith({
    List<DrawerItemData> drawerItems,
    int indexDrawerSelected,
    List<Task> listAllTask,
    List<Project> listProject,
    List<Label> listLabel,
    bool loading,
    String msg,
  }) {
    if ((drawerItems == null || identical(drawerItems, this.drawerItems)) &&
        (indexDrawerSelected == null ||
            identical(indexDrawerSelected, this.indexDrawerSelected)) &&
        (listAllTask == null || identical(listAllTask, this._listAllTask)) &&
        (listProject == null || identical(listProject, this.listProject)) &&
        (listLabel == null || identical(listLabel, this.listLabel)) &&
        (loading == null || identical(loading, this.loading)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return DisplayListTasks(
      drawerItems: drawerItems ?? this.drawerItems,
      indexDrawerSelected: indexDrawerSelected ?? this.indexDrawerSelected,
      listAllTask: listAllTask ?? _listAllTask,
      listProject: listProject ?? this.listProject,
      listLabel: listLabel ?? this.listLabel,
      loading: loading ?? this.loading,
      msg: msg ?? this.msg,
    );
  }
}
