import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/util.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ITaskRepository _taskRepository;

  HomeBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(HomeState.loading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OpenHomeScreen) {
      yield* _mapOpenHomeScreenToState();
    } else if (event is SelectedDrawerIndexChanged) {
      yield* _mapSelectedDrawerIndexChangedToState(
          indexDrawerSelected: event.index);
    } else if (event is SelectedBottomNavigationIndexChanged) {
      yield* _mapSelectedBottomNavigationIndexChangedToState(event.index);
    } else if (event is UpdateTaskEvent) {
      yield* _mapUpdateTaskEventToState(event.task);
    } else if (event is DataListLabelChanged) {
      yield* _mapDataLabelChangedState();
    } else if (event is DataProjectChanged) {
      yield* _mapDataProjectChangedState();
    } else if (event is DataListTaskChanged) {
      yield* _mapDataListTaskChangedState();
    } else if (event is ShowCompletedTaskChange) {
      yield* _mapShowCompletedTaskChangeToState();
    } else if (event is DeleteLabel) {
      yield* _mapDeleteLabelToState();
    } else if (event is DeleteProject) {
      yield* _mapDeleteProjectToState();
    }
  }

  Stream<HomeState> _mapSelectedDrawerIndexChangedToState(
      {int indexDrawerSelected}) async* {
    yield state.copyWith(indexDrawerSelected: indexDrawerSelected);
  }

  Stream<HomeState> _mapSelectedBottomNavigationIndexChangedToState(
      int indexSelected) async* {
    yield state.copyWith(indexNavigationBarSelected: indexSelected);
  }

  Stream<HomeState> _mapOpenHomeScreenToState() async* {
    yield HomeState.loading();

    try {
      final listAllTask = await _taskRepository.getAllTask();
      final listProject = await _taskRepository.getProjects();
      final listLabel = await _taskRepository.getLabels();
      // final listSection = await _taskRepository.getSections();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, listProject, listLabel);

      yield state.copyWith(
          listAllTask: listAllTask,
          listProject: listProject,
          listLabel: listLabel,
          listSection: [],
          //TODO handle section
          drawerItems: drawerItems,
          loading: false);
    } catch (e, stackTrace) {
      log("error:( $stackTrace");
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapUpdateTaskEventToState(Task updateTask) async* {
    try {
      if (updateTask != null) {
        if (updateTask.isCompleted) {
          await _taskRepository.updateTask(updateTask.copyWith(
              completedDate: DateTime.now().toIso8601String()));
        } else {
          await _taskRepository
              .updateTask(updateTask.copyWith(completedDate: ''));
        }

        final listAllTask = await _taskRepository.getAllTask();
        yield state.copyWith(listAllTask: listAllTask);
      }
    } catch (e, stackTrace) {
      log("error:( $stackTrace");
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapDataLabelChangedState() async* {
    try {
      final listLabel = await _taskRepository.getLabels();
      final drawerItems = <DrawerItemData>[];
      _initDrawerItems(drawerItems, state.listProject, listLabel);

      yield state.copyWith(
          listLabel: listLabel, drawerItems: drawerItems, loading: false);
    } catch (e, stackTrace) {
      log("error:( $stackTrace");
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapDataProjectChangedState() async* {
    try {
      final listProject = await _taskRepository.getProjects();
      final drawerItems = <DrawerItemData>[];
      _initDrawerItems(drawerItems, listProject, state.listLabel);
      yield state.copyWith(
          listProject: listProject, drawerItems: drawerItems, loading: false);
    } catch (e, stackTrace) {
      log("error:( $stackTrace");
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapDataListTaskChangedState() async* {
    try {
      final listAllTask = await _taskRepository.getAllTask();

      yield state.copyWith(listAllTask: listAllTask);
    } catch (e, stackTrace) {
      log("error:( $stackTrace");
      yield HomeState.error(e.toString());
    }
  }

  // Stream<HomeState> _mapDataListSectionChangedToState() async* {
  //   try {
  //     // final listSection = await _taskRepository.getSections();
  //     //TODO Handle sector
  //     // yield state.copyWith(listSection: listSection);
  //   } catch (e, stackTrace) {
  //     log("error:( $stackTrace");
  //     yield HomeState.error(e.toString());
  //   }
  // }

  Stream<HomeState> _mapShowCompletedTaskChangeToState() async* {
    yield state.copyWith(isShowCompletedTask: !state.isShowCompletedTask);
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

    drawerItems.addAll(DrawerItemData.listDrawerItemFilterInit);
  }

  Stream<HomeState> _mapDeleteLabelToState() async* {
    try {
      final selectedLabel =
          state.drawerItems[state.indexDrawerSelected].data as Label;

      await _taskRepository
          .updateLabel(selectedLabel.copyWith(isTrashed: true));

      final listTask = state.allTasks.where((element) {
        if (element.labels?.isEmpty ?? true) {
          return false;
        }
        return element.labels.contains(selectedLabel);
      }).toList();

      final updatedTasks = listTask.map((e) {
        final updatedLabel = e.labels;
        updatedLabel.remove(selectedLabel);
        return e.copyWith(labels: updatedLabel);
      });

      await Future.wait(updatedTasks.map((e) => _taskRepository.updateTask(e)));

      final listAllTask = await _taskRepository.getAllTask();
      final listLabel = await _taskRepository.getLabels();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, state.listProject, listLabel);

      yield state.copyWith(
          listAllTask: listAllTask,
          listLabel: listLabel,
          drawerItems: drawerItems,
          indexDrawerSelected: HomeState.kDrawerIndexInbox,
          loading: false);
    } catch (e) {
      yield state.copyWith(msg: e.toString());
    }
  }

  Stream<HomeState> _mapDeleteProjectToState() async* {
    try {
      final selectedProject =
          state.drawerItems[state.indexDrawerSelected].data as Project;
      await _taskRepository.deleteProject(selectedProject.id);

      final listTask = state.allTasks.where((element) {
        if (element.project?.id?.isEmpty ?? true) {
          return false;
        }
        return element.project.id == selectedProject.id;
      }).toList();

      await Future.wait(listTask.map((e) => _taskRepository
          .updateTask(e.copyWith(isTrashed: true, project: const Project()))));
      // await Future.wait(
      //     listTask.map((e) => _taskRepository.updateTask(e.copyWith(
      //           isTrashed: false,
      //         ))));

      final listAllTask = await _taskRepository.getAllTask();
      final listProject = await _taskRepository.getProjects();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, listProject, state.listLabel);

      yield state.copyWith(
          listAllTask: listAllTask,
          listProject: listProject,
          drawerItems: drawerItems,
          indexDrawerSelected: HomeState.kDrawerIndexInbox,
          loading: false);
    } catch (e, stackTrace) {
      log('TraceStack', stackTrace);
      yield state.copyWith(msg: e.toString());
    }
  }
}
