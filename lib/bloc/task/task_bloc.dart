import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
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
    } else if (event is TaskAddChanged) {
      yield* _mapTaskAddChangedToState(event);
    } else if (event is AddTask) {
      yield* _mapAddTaskToState();
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event.task);
    } else if (event is SelectedDrawerIndexChanged) {
      yield* _mapSelectedDrawerIndexChangedToState(
          indexDrawerSelected: event.index);
    } else if (event is OpenBottomSheetAddTask) {
      yield* _mapOpenBottomSheetAddTaskToState();
    }
  }

  Stream<TaskState> _mapSelectedDrawerIndexChangedToState(
      {int indexDrawerSelected}) async* {
    if (state is DisplayListTasks) {
      yield (state as DisplayListTasks)
          .copyWith(indexDrawerSelected: indexDrawerSelected);
    }
  }

  Stream<TaskState> _mapOpenBottomSheetAddTaskToState() async* {
    if (state is DisplayListTasks) {
      yield (state as DisplayListTasks).copyWith(taskAdd: const Task());
    }
  }

  Stream<TaskState> _mapTaskUpdatedToState(Task task) async* {
    print("Update current state: ${state}");
    if (state is DisplayListTasks) {
      await _taskRepository.updateTask(task);
      final listAllTask = await _taskRepository.getAllTask();
      final newState =
          (state as DisplayListTasks).copyWith(listAllTask: listAllTask);
      yield newState;
    }
  }

  Stream<TaskState> _mapAddTaskToState() async* {
    // print("_mapAddTaskToState current state: ${state}");
    if (state is DisplayListTasks) {
      await _taskRepository.addTask((state as DisplayListTasks).taskAdd);
      final listAllTask = await _taskRepository.getAllTask();

      yield (state as DisplayListTasks).copyWith(
        listAllTask: listAllTask,
      );
    }
  }

  Stream<TaskState> _mapTaskAddChangedToState(TaskAddChanged event) async* {
    // print("_mapTaskAddChangedToState ${(state as DisplayListTasks).taskAdd}");
    if (state is DisplayListTasks) {
      var taskAdd = (state as DisplayListTasks).taskAdd;
      taskAdd = taskAdd.copyWith(taskName: event.taskName);
      taskAdd = taskAdd.copyWith(priorityType: event.priority);
      taskAdd = taskAdd.copyWith(taskDate: event.taskDate);
      taskAdd = taskAdd.copyWith(projectId: event.project?.id);
      taskAdd = taskAdd.copyWith(projectName: event.project?.nameProject);

      // print("_mapTaskAddChangedToState ${taskAdd}");

      yield (state as DisplayListTasks).updateTask(taskAdd);
    }
  }

  Stream<TaskState> _mapOpenHomeScreenToState() async* {
    yield DisplayListTasks.loading();

    try {
      final listAllTask = await _taskRepository.getAllTask();
      final listProject = await _taskRepository.getProjects();
      final listLabel = await _taskRepository.getLabels();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, listProject, listLabel);

      yield (state as DisplayListTasks).copyWith(
          listAllTask: listAllTask,
          listProject: listProject,
          drawerItems: drawerItems,
          loading: false);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }

  void _initDrawerItems(List<DrawerItemData> drawerItems,
      List<Project> listProject, List<Label> listLabel) {
    drawerItems.addAll(DrawerItemData.listDrawerItemDateInit);

    for (final project in listProject) {
      drawerItems.add(
        DrawerItemData(project.nameProject, "assets/ic_circle_64.png",
            type: DrawerItemData.kTypeProject, data: project),
      );
    }

    for (final label in listLabel) {
      drawerItems.add(
        DrawerItemData(label.nameLabel, "assets/ic_circle_64.png",
            type: DrawerItemData.kTypeLabel, data: label),
      );
    }
  }
}
