import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/notification_helper.dart';

import 'bloc.dart';

class TaskAddBloc extends Bloc<TaskAddEvent, TaskAddState> {
  final ITaskRepository _taskRepository;

  TaskAddBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const TaskAddState());

  @override
  Stream<TaskAddState> mapEventToState(TaskAddEvent event) async* {
    if (event is TaskAddChanged) {
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
    taskAdd = taskAdd.copyWith(taskDate: event.taskDate);
    taskAdd = taskAdd.copyWith(project: event.project);
    taskAdd = taskAdd.copyWith(labels: event.labels);
    taskAdd = taskAdd.copyWith(sectionId: event.sectionId);

    yield state.updateTask(taskAdd);
  }

  Stream<TaskAddState> _mapSubmitAddTaskToState() async* {
    final Task taskSubmit = state.taskAdd.copyWith(
        id: state.taskAdd.id ??
            DateTime.now().microsecondsSinceEpoch.toString());

    await _taskRepository.addTask(taskSubmit);

    if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
      showNotificationScheduledWithTask(taskSubmit);
    }

    yield state.copyWith(
      success: true,
      taskSubmit: const Task(),
    );
  }
}
