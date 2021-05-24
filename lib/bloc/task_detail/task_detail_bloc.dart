import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/notification_helper.dart';

import 'bloc.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final ITaskRepository _taskRepository;

  TaskDetailBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const TaskDetailState());

  @override
  Stream<TaskDetailState> mapEventToState(TaskDetailEvent event) async* {
    if (event is OpenScreenEditTask) {
      yield* _mapOpenScreenEditTaskToState(event.task);
    } else if (event is OpenScreenEditTaskWithId) {
      yield* _mapOpenScreenEditTaskWithIdToState(event.taskId);
    } else if (event is SubmitEditTask) {
      yield* _mapSubmitEditTaskToState(event.task);
    } else if (event is UpdateItemCheckList) {
      yield* _mapUpdateItemCheckListToState(event.checkItem);
    } else if (event is DeleteCheckItem) {
      yield* _mapDeleteCheckItemToState(event.idCheckItem);
    } else if (event is TaskSubmitDateChanged) {
      yield* _mapTaskSubmitDateChangedToState(event.taskDate);
    } else if (event is DeleteTask) {
      yield* _mapDeleteTaskToState();
    }
  }

  Stream<TaskDetailState> _mapDeleteCheckItemToState(
      String checkItemId) async* {
    final checkList = <CheckItem>[];

    checkList.addAll(state.taskEdit.checkList);

    checkList.removeWhere((element) => element.id == checkItemId);

    final taskUpdate = state.taskEdit.copyWith(checkList: checkList);

    await _taskRepository.updateTask(taskUpdate);

    yield state.copyWith(taskEdit: taskUpdate);
  }

  Stream<TaskDetailState> _mapUpdateItemCheckListToState(
      CheckItem checkItem) async* {
    final checkList = <CheckItem>[];
    checkList.addAll(state.taskEdit.checkList);

    var indexUpdate = -1;
    for (var i = 0; i < checkList.length; i++) {
      if (checkList[i].id == checkItem.id) {
        indexUpdate = i;
        break;
      }
    }

    if (indexUpdate >= 0) {
      checkList[indexUpdate] = checkItem;
    }

    final taskUpdate = state.taskEdit.copyWith(checkList: checkList);

    await _taskRepository.updateTask(taskUpdate);

    yield state.copyWith(taskEdit: taskUpdate);
  }

  Stream<TaskDetailState> _mapOpenScreenEditTaskToState(Task task) async* {
    yield state.copyWith(taskEdit: task);
  }

  Stream<TaskDetailState> _mapOpenScreenEditTaskWithIdToState(
      String idTask) async* {
    yield state.copyWith(loading: true);
    final task = await _taskRepository.getDetailTask(idTask);
    yield state.copyWith(taskEdit: task, loading: false);
  }

  Stream<TaskDetailState> _mapSubmitEditTaskToState(Task updateTask) async* {
    Task _updateTask = updateTask ?? state.taskEdit;

    if (_updateTask.isCompleted != state.taskEdit.isCompleted) {
      if (_updateTask.isCompleted) {
        _updateTask = _updateTask.copyWith(
            completedDate: DateTime.now().toIso8601String());
      } else {
        _updateTask = _updateTask.copyWith(completedDate: '');
      }
    }

    await _taskRepository.updateTask(_updateTask);

    yield state.copyWith(
      taskEdit: _updateTask,
    );
  }

  Stream<TaskDetailState> _mapTaskSubmitDateChangedToState(
      String taskDate) async* {
    var taskEdit = state.taskEdit;
    if (taskDate != taskEdit.taskDate) {
      await AwesomeNotifications().cancelSchedule(taskEdit.id.hashCode);
      if (taskDate != null) {
        taskEdit = taskEdit.copyWith(taskDate: taskDate);
        await showNotificationScheduledWithTask(taskEdit);
        await _taskRepository.updateTask(taskEdit);
        yield state.copyWith(
          taskEdit: taskEdit,
        );
      }
      //TODO update task with noDate
    }
  }

  Stream<TaskDetailState> _mapDeleteTaskToState() async* {
    await _taskRepository.updateTask(state.taskEdit.copyWith(isTrashed: true));
    yield state.copyWith(taskEdit: state.taskEdit.copyWith(isTrashed: true));
  }
}
