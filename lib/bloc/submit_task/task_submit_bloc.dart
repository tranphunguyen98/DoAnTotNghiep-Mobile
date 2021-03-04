import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/task.dart';

import 'bloc.dart';

class TaskSubmitBloc extends Bloc<TaskSubmitEvent, TaskSubmitState> {
  final ITaskRepository _taskRepository;

  TaskSubmitBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const TaskSubmitState());

  @override
  Stream<TaskSubmitState> mapEventToState(TaskSubmitEvent event) async* {
    // print("EVENT: $event");
    if (event is OpenScreenEditTask) {
      yield* _mapOpenScreenEditTaskToState(event.task);
    } else if (event is TaskSubmitChanged) {
      yield* _mapTaskSubmitChangeToState(event);
    } else if (event is SubmitAddTask) {
      yield* _mapSubmitAddTaskToState();
    } else if (event is SubmitEditTask) {
      yield* _mapSubmitEditTaskToState(event.task);
    } else if (event is OpenBottomSheetAddTask) {
      yield* _mapOpenBottomSheetAddTaskToState();
    } else if (event is HandledSuccessState) {
      yield* _mapHandledSuccessStateToState();
    } else if (event is UpdateItemCheckList) {
      yield* _mapUpdateItemCheckListToState(event.checkItem);
    } else if (event is DeleteCheckItem) {
      yield* _mapDeleteCheckItemToState(event.idCheckItem);
    }
  }

  // Stream<TaskSubmitState> _mapOpenBottomSheetAddTaskToState() async* {
  //   if (state is DisplayListTasks) {
  //     yield (state as DisplayListTasks).copyWith(taskSubmit: const Task());
  //   }
  // }

  Stream<TaskSubmitState> _mapHandledSuccessStateToState() async* {
    yield state.copyWith(success: false);
  }

  Stream<TaskSubmitState> _mapDeleteCheckItemToState(
      String checkItemId) async* {
    final checkList = state.taskSubmit.checkList;
    checkList.removeWhere((element) => element.id == checkItemId);

    final taskUpdate = state.taskSubmit.copyWith(checkList: checkList);

    await _taskRepository.updateTask(taskUpdate);

    yield state.copyWith(taskSubmit: taskUpdate, success: true);
  }

  Stream<TaskSubmitState> _mapUpdateItemCheckListToState(
      CheckItem checkItem) async* {
    final checkList = state.taskSubmit.checkList;

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

    print("checkList: ${checkList != state.taskSubmit.checkList}");

    final taskUpdate = state.taskSubmit.copyWith(checkList: checkList);

    await _taskRepository.updateTask(taskUpdate);

    yield state.copyWith(taskSubmit: taskUpdate, success: true);
  }

  Stream<TaskSubmitState> _mapOpenScreenEditTaskToState(Task task) async* {
    yield state.copyWith(taskSubmit: task);
  }

  Stream<TaskSubmitState> _mapSubmitEditTaskToState(Task task) async* {
    if (task != null) {
      await _taskRepository.updateTask(task);
      print("UPDATE ${state.taskSubmit} --------------- $task");
      yield state.copyWith(
        taskSubmit: task,
        success: true,
      );
    } else {
      await _taskRepository.updateTask(state.taskSubmit);
      yield state.copyWith(
        success: true,
      );
    }
  }

  Stream<TaskSubmitState> _mapTaskSubmitChangeToState(
      TaskSubmitChanged event) async* {
    print("_mapTaskAddChangedToState ${state.taskSubmit}");
    var taskAdd = state.taskSubmit;
    taskAdd = taskAdd.copyWith(name: event.taskName);
    taskAdd = taskAdd.copyWith(priorityType: event.priority);
    taskAdd = taskAdd.copyWith(taskDate: event.taskDate);
    taskAdd = taskAdd.copyWith(project: event.project);
    taskAdd = taskAdd.copyWith(labels: event.labels);
    taskAdd = taskAdd.copyWith(sectionId: event.sectionId);
    print("_mapTaskAddChangedToState 2 ${taskAdd}");

    yield state.updateTask(taskAdd);
  }

  Stream<TaskSubmitState> _mapSubmitAddTaskToState() async* {
    print("Submit task");
    print("Submit add Task ${state.taskSubmit}");
    await _taskRepository.addTask(state.taskSubmit);

    yield state.copyWith(
      success: true,
      taskSubmit: const Task(),
    );
  }

  Stream<TaskSubmitState> _mapOpenBottomSheetAddTaskToState() async* {
    yield const TaskSubmitState();
  }
}
