import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/utils/util.dart';
import 'package:totodo/utils/validators.dart';

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
    } else if (event is InitProject) {
      yield* _mapInitProjectToState(event.project);
    }
  }

  Stream<AddProjectState> _mapNameProjectChangedToState(
      String name, String color) async* {
    //TODO separate to name and color
    final projectNew = state.project.copyWith(name: name, color: color);
    log('$name $color $projectNew');
    yield state.copyWith(
      project: projectNew,
      isProjectNameValid:
          name != null ? Validators.isValidName(projectNew.name ?? '') : null,
    );
  }

  Stream<AddProjectState> _mapAddProjectSubmitToState() async* {
    try {
      if (state.project?.name?.isEmpty ?? true) {
        yield state.failed("Tên nhãn rỗng!");
      } else {
        if (state.project.id?.isEmpty ?? true) {
          await _taskRepository.addProject(state.project);
        } else {
          await _taskRepository.updateProject(state.project);
        }
        yield AddProjectState.success();
      }
    } catch (e) {
      yield state.failed(e.toString());
    }
  }

  Stream<AddProjectState> _mapInitProjectToState(Project project) async* {
    yield state.copyWith(project: project);
  }
}
