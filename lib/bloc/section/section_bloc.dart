import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';

import 'bloc.dart';

class AddSectionBloc extends Bloc<AddSectionEvent, AddSectionState> {
  final ITaskRepository _taskRepository;

  AddSectionBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const AddSectionState());

  @override
  Stream<AddSectionState> mapEventToState(AddSectionEvent event) async* {
    if (event is NameSectionAddChanged) {
      yield* _mapNameSectionChangedToState(event.name);
    } else if (event is ProjectIdSectionAddChanged) {
      yield* _mapProjectIdSectionAddChangedToState(event.projectId);
    } else if (event is AddSectionSubmit) {
      yield* _mapAddSectionSubmitToState();
    } else if (event is OpenAddSectionEvent) {
      yield const AddSectionState();
    }
  }

  Stream<AddSectionState> _mapNameSectionChangedToState(String name) async* {
    if (name.isEmpty) {
      yield state.copyWith(
        section: state.section.copyWith(name: name),
        isValidNameSection: false,
      );
    } else {
      yield state.copyWith(
        section: state.section.copyWith(name: name),
        isValidNameSection: true,
      );
    }
  }

  Stream<AddSectionState> _mapProjectIdSectionAddChangedToState(
      String projectId) async* {
    if (projectId.isNotEmpty) {
      yield state.copyWith(
        section: state.section.copyWith(projectId: projectId),
      );
    }
  }

  Stream<AddSectionState> _mapAddSectionSubmitToState() async* {
    try {
      if (state.section?.name?.isEmpty ?? true) {
        yield state.failed("Tên Section rỗng!");
      } else {
        await _taskRepository.addSection(state.section);
        yield AddSectionState.success();
      }
    } catch (e) {
      yield state.failed(e.toString());
    }
  }
}
