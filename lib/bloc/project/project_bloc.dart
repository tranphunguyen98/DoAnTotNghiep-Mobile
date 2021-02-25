import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';

import 'bloc.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  final ITaskRepository _taskRepository;

  AddProjectBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const AddProjectState());

  @override
  Stream<AddProjectState> mapEventToState(AddProjectEvent event) async* {
    if (event is AddedProjectChanged) {
      yield* _mapNameProjectChangedToState(event.name, event.color);
    } else if (event is AddProjectSubmit) {
      yield* _mapAddProjectSubmitToState();
    } else if (event is OpenAddProjectEvent) {
      yield const AddProjectState();
    }
  }

  Stream<AddProjectState> _mapNameProjectChangedToState(
      String name, String color) async* {
    yield state.copyWith(
      project: state.project.copyWith(name: name, color: color),
      msg: '',
    );
  }

  Stream<AddProjectState> _mapAddProjectSubmitToState() async* {
    try {
      if (state.project?.name?.isEmpty ?? true) {
        yield state.failed("Tên nhãn rỗng!");
      } else {
        await _taskRepository.addProject(state.project);
        yield AddProjectState.success();
      }
    } catch (e) {
      yield state.failed(e.toString());
    }
  }
}
