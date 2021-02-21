import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/task.dart';

import 'bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository _taskRepository;

  TaskBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(null);

  @override
  TaskState get initialState => DisplayListTasks.loading();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is OpenHomeScreen) {
      yield* _mapOpenHomeScreenToState();
    } else if (event is TaskAddChanged) {
      yield* _mapTaskAddChangedToState(
          taskName: event.taskName, priority: event.priority);
    } else if (event is AddTask) {
      yield* _mapAddTaskToState();
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event.task);
    }
  }

  Stream<TaskState> _mapTaskUpdatedToState(Task task) async* {
    if (state is DisplayListTasks) {
      await _taskRepository.updateTask(task);
      final listAllTask = await _taskRepository.getAllTask();
      yield DisplayListTasks.data(listAllTask);
    }
  }

  Stream<TaskState> _mapAddTaskToState() async* {
    print("_mapAddTaskToState current state: ${state}");
    if (state is DisplayListTasks) {
      await _taskRepository.addTask((state as DisplayListTasks).taskAdd);
      final listAllTask = await _taskRepository.getAllTask();
      yield DisplayListTasks.data(listAllTask);
    }
  }

  Stream<TaskState> _mapTaskAddChangedToState(
      {String taskName, int priority}) async* {
    if (state is DisplayListTasks) {
      var taskAdd = (state as DisplayListTasks).taskAdd;
      taskAdd = taskAdd.copyWith(taskName: taskName);
      taskAdd = taskAdd.copyWith(priorityType: priority);

      yield (state as DisplayListTasks).updateTask(taskAdd);
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
