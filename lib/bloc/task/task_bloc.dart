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
    } else if (event is TaskChanged) {
      yield* _mapTaskChangedToState(event.taskAdd);
    } else if (event is AddTask) {
      yield* _mapAddTaskToState();
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

  Stream<TaskState> _mapTaskChangedToState(Task taskAdd) async* {
    if (state is DisplayListTasks) {
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
