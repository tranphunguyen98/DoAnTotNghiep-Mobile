import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';

import 'bloc.dart';

class TaskAddBloc extends Bloc<TaskAddEvent, TaskAddState> {
  final ITaskRepository _taskRepository;

  TaskAddBloc({
    @required ITaskRepository taskRepository,
  })  : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const TaskAddState());

  @override
  Stream<TaskAddState> mapEventToState(TaskAddEvent event) async* {
    if (event is OnDataTaskAddChanged) {
      yield* _mapOnDataTaskAddChangedToState();
    } else if (event is TaskAddChanged) {
      yield* _mapTaskSubmitChangeToState(event);
    } else if (event is SubmitAddTask) {
      yield* _mapSubmitAddTaskToState();
    }
  }

  Stream<TaskAddState> _mapTaskSubmitChangeToState(
      TaskAddChanged event) async* {
    var taskAdd = state.taskAdd;
    taskAdd = taskAdd.copyWith(name: event.taskName);
    taskAdd = taskAdd.copyWith(priority: event.priority);
    taskAdd = taskAdd.copyWith(dueDate: event.taskDate);
    taskAdd = taskAdd.copyWith(project: event.project);
    taskAdd = taskAdd.copyWith(labels: event.labels);
    taskAdd = taskAdd.copyWith(sectionId: event.sectionId);
    taskAdd = taskAdd.copyWith(crontabSchedule: event.crontabSchedule);

    yield state.updateTask(taskAdd);
  }

  Stream<TaskAddState> _mapOnDataTaskAddChangedToState() async* {
    // log("_mapOnDataTaskAddChangedToState :");
    final labels = await _taskRepository.getLabels();
    final projects = await _taskRepository.getProjects();
    // log("Labels : $labels");
    yield state.copyWith(
      labels: labels,
      projects: projects,
    );
  }

  Stream<TaskAddState> _mapSubmitAddTaskToState() async* {
    final Task taskSubmit = state.taskAdd.copyWith();

    try {
      await _taskRepository.addTask(taskSubmit);
    } catch (e) {
      yield state.copyWith(errorMessage: e.toString());
    }

    yield state.copyWith(
      success: true,
      taskAdd: const Task(),
    );
  }
}
