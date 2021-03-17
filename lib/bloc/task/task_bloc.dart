import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';

import 'bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository _taskRepository;

  TaskBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(DisplayListTasks.loading());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is OpenHomeScreen) {
      yield* _mapOpenHomeScreenToState();
    } else if (event is SelectedDrawerIndexChanged) {
      yield* _mapSelectedDrawerIndexChangedToState(
          indexDrawerSelected: event.index);
    } else if (event is DataLabelChanged) {
      yield* _mapDataLabelChangedState();
    } else if (event is DataProjectChanged) {
      yield* _mapDataProjectChangedState();
    } else if (event is DataListTaskChanged) {
      yield* _mapDataListTaskChangedState();
    } else if (event is DataListSectionChanged) {
      yield* _mapDataListSectionChangedToState();
    }
  }

  Stream<TaskState> _mapSelectedDrawerIndexChangedToState(
      {int indexDrawerSelected}) async* {
    if (state is DisplayListTasks) {
      yield (state as DisplayListTasks)
          .copyWith(indexDrawerSelected: indexDrawerSelected);
    }
  }

  Stream<TaskState> _mapOpenHomeScreenToState() async* {
    yield DisplayListTasks.loading();

    try {
      final listAllTask = await _taskRepository.getAllTask();
      final listProject = await _taskRepository.getProjects();
      final listLabel = await _taskRepository.getLabels();
      final listSection = await _taskRepository.getSections();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, listProject, listLabel);

      yield (state as DisplayListTasks).copyWith(
          listAllTask: listAllTask,
          listProject: listProject,
          listLabel: listLabel,
          listSection: listSection,
          drawerItems: drawerItems,
          loading: false);
    } catch (e) {
      // print("error:( ${e.toString()}");
      // print("error:( ${trance}");
      yield DisplayListTasks.error(e.toString());
    }
  }

  Stream<TaskState> _mapDataLabelChangedState() async* {
    try {
      final listLabel = await _taskRepository.getLabels();
      final drawerItems = <DrawerItemData>[];
      _initDrawerItems(
          drawerItems, (state as DisplayListTasks).listProject, listLabel);

      yield (state as DisplayListTasks).copyWith(
          listLabel: listLabel, drawerItems: drawerItems, loading: false);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }

  Stream<TaskState> _mapDataProjectChangedState() async* {
    try {
      final listProject = await _taskRepository.getProjects();
      final drawerItems = <DrawerItemData>[];
      _initDrawerItems(
          drawerItems, listProject, (state as DisplayListTasks).listLabel);

      yield (state as DisplayListTasks).copyWith(
          listProject: listProject, drawerItems: drawerItems, loading: false);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }

  Stream<TaskState> _mapDataListTaskChangedState() async* {
    try {
      final listAllTask = await _taskRepository.getAllTask();

      yield (state as DisplayListTasks).copyWith(listAllTask: listAllTask);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }

  Stream<TaskState> _mapDataListSectionChangedToState() async* {
    try {
      final listSection = await _taskRepository.getSections();

      yield (state as DisplayListTasks).copyWith(listSection: listSection);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }

  void _initDrawerItems(List<DrawerItemData> drawerItems,
      List<Project> listProject, List<Label> listLabel) {
    drawerItems.addAll(DrawerItemData.listDrawerItemDateInit);

    for (final project in listProject) {
      drawerItems.add(
        DrawerItemData(project.name, Icons.circle,
            type: DrawerItemData.kTypeProject, data: project),
      );
    }

    for (final label in listLabel) {
      drawerItems.add(
        DrawerItemData(label.name, Icons.circle,
            type: DrawerItemData.kTypeLabel, data: label),
      );
    }
  }

// Stream<TaskState> _mapTaskUpdatedToState(Task task) async* {
//   print("Update current state: ${state}");
//   if (state is DisplayListTasks) {
//     await _taskRepository.updateTask(task);
//     final listAllTask = await _taskRepository.getAllTask();
//     final newState =
//         (state as DisplayListTasks).copyWith(listAllTask: listAllTask);
//     yield newState;
//   }
// }

// Stream<TaskState> _mapAddTaskToState() async* {
//   // print("_mapAddTaskToState current state: ${state}");
//   if (state is DisplayListTasks) {
//     await _taskRepository.addTask((state as DisplayListTasks).taskSubmit);
//     final listAllTask = await _taskRepository.getAllTask();
//
//     yield (state as DisplayListTasks).copyWith(
//       listAllTask: listAllTask,
//       taskSubmit: const Task(),
//     );
//   }
// }
}
