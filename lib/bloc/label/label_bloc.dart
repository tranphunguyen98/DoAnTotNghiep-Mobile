import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';

import 'bloc.dart';

class AddLabelBloc extends Bloc<AddLabelEvent, AddLabelState> {
  final ITaskRepository _taskRepository;

  AddLabelBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const AddLabelState());

  @override
  Stream<AddLabelState> mapEventToState(AddLabelEvent event) async* {
    if (event is AddedLabelChanged) {
      yield* _mapNameLabelChangedToState(event);
    } else if (event is AddLabelSubmit) {
      yield* _mapAddLabelSubmitToState();
    } else if (event is InitLabel) {
      yield* _mapInitLabelToState(event.label);
    }
  }

  Stream<AddLabelState> _mapNameLabelChangedToState(
      AddedLabelChanged event) async* {
    yield state.copyWith(
        label: state.label.copyWith(name: event.name, color: event.color),
        msg: '');
  }

  Stream<AddLabelState> _mapAddLabelSubmitToState() async* {
    try {
      if (state.label?.name?.isEmpty ?? true) {
        yield state.failed("Tên nhãn rỗng!");
      } else {
        if (state.label.id?.isEmpty ?? true) {
          await _taskRepository.addLabel(state.label);
        } else {
          await _taskRepository.updateLabel(state.label);
        }
        yield AddLabelState.success();
      }
    } catch (e) {
      yield state.failed(e.toString());
    }
  }

  Stream<AddLabelState> _mapInitLabelToState(Label label) async* {
    yield state.copyWith(label: label);
  }
}
