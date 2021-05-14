import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/remote/unauthenticated_exception.dart';
import 'package:totodo/utils/notification_helper.dart';
import 'package:totodo/utils/util.dart';

import 'bloc.dart';

class TaskAddBloc extends Bloc<TaskAddEvent, TaskAddState> {
  final ITaskRepository _taskRepository;
  final IUserRepository _userRepository;

  TaskAddBloc({
    @required ITaskRepository taskRepository,
    @required IUserRepository userRepository,
  })  : assert(taskRepository != null),
        _taskRepository = taskRepository,
        _userRepository = userRepository,
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
    taskAdd = taskAdd.copyWith(taskDate: event.taskDate);
    taskAdd = taskAdd.copyWith(project: event.project);
    taskAdd = taskAdd.copyWith(labels: event.labels);
    taskAdd = taskAdd.copyWith(sectionId: event.sectionId);

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
    final Task taskSubmit = state.taskAdd.copyWith(
        id: state.taskAdd.id ??
            DateTime.now().microsecondsSinceEpoch.toString());

    try {
      await _taskRepository.addTask(taskSubmit);
    } on UnauthenticatedException catch (e) {
      log('UnauthenticatedException', e);
      await _userRepository.renewUser();
      await _taskRepository.addTask(taskSubmit);
    } catch (e) {
      yield state.copyWith(errorMessage: e.toString());
      //TODO handle error
    }
    if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
      showNotificationScheduledWithTask(taskSubmit);
    }

    yield state.copyWith(
      success: true,
      taskAdd: const Task(),
    );
  }
}
