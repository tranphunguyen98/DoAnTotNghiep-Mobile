import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/task.dart';

import 'bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository _taskRepository;

  TaskBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository;

  @override
  TaskState get initialState => DisplayListTasks.loading();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is OpenHomeScreen) {
      yield* _mapOpenHomeScreenToState();
    } else if (event is CanAddTaskChanged) {
      yield* _mapCanAddTaskChangedToState(event.canAddTask);
    } else if (event is AddTask) {
      yield* _mapAddTaskToState(event.task);
    }
  }

  Stream<TaskState> _mapAddTaskToState(Task task) async* {
    print("_mapAddTaskToState current state: ${state}");
    await _taskRepository.addTask(task);
    final listAllTask = await _taskRepository.getAllTask();
    yield DisplayListTasks.data(listAllTask);
  }

  Stream<TaskState> _mapCanAddTaskChangedToState(bool canAddTask) async* {
    if (state is DisplayListTasks) {
      if ((state as DisplayListTasks).canAddTask != canAddTask) {
        yield (state as DisplayListTasks)
            .updateCanAddTask(canAddTask: canAddTask);
      }
    }
  }

  Stream<TaskState> _mapOpenHomeScreenToState() async* {
    yield DisplayListTasks.loading();

    try {
      final listAllTask = await _taskRepository.getAllTask();

      yield DisplayListTasks.data(listAllTask);
    } catch (e) {
      yield DisplayListTasks.error(e.toString());
    }
  }
}
