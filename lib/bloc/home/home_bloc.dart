import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';

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
    } else if (event is UpdateTaskEvent) {
      yield* _mapUpdateTaskEventToState(event.task);
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

  Stream<HomeState> _mapSelectedDrawerIndexChangedToState(
      {int indexDrawerSelected}) async* {
    yield state.copyWith(indexDrawerSelected: indexDrawerSelected);
  }

  Stream<HomeState> _mapOpenHomeScreenToState() async* {
    yield HomeState.loading();

    try {
      final listAllTask = await _taskRepository.getAllTask();
      final listProject = await _taskRepository.getProjects();
      final listLabel = await _taskRepository.getLabels();
      final listSection = await _taskRepository.getSections();
      final drawerItems = <DrawerItemData>[];

      _initDrawerItems(drawerItems, listProject, listLabel);

      yield state.copyWith(
          listAllTask: listAllTask,
          listProject: listProject,
          listLabel: listLabel,
          listSection: listSection,
          drawerItems: drawerItems,
          loading: false);
    } catch (e) {
      // print("error:( ${e.toString()}");
      // print("error:( ${trance}");
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapUpdateTaskEventToState(Task task) async* {
    try {
      if (task != null) {
        await _taskRepository.updateTask(task);
        final listAllTask = await _taskRepository.getAllTask();
        yield state.copyWith(listAllTask: listAllTask);
      }
    } catch (e) {
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
    } catch (e) {
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
    } catch (e) {
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapDataListTaskChangedState() async* {
    try {
      final listAllTask = await _taskRepository.getAllTask();

      yield state.copyWith(listAllTask: listAllTask);
    } catch (e) {
      yield HomeState.error(e.toString());
    }
  }

  Stream<HomeState> _mapDataListSectionChangedToState() async* {
    try {
      final listSection = await _taskRepository.getSections();

      yield state.copyWith(listSection: listSection);
    } catch (e) {
      yield HomeState.error(e.toString());
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
}
