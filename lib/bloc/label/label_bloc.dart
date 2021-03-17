import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';

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
    } else if (event is OpenAddLabelEvent) {
      yield const AddLabelState();
    }
  }

  Stream<AddLabelState> _mapNameLabelChangedToState(
      AddedLabelChanged event) async* {
    yield state.copyWith(
        label: state.label
            .copyWith(nameLabel: event.nameLabel, color: event.color),
        msg: '');
  }

  Stream<AddLabelState> _mapAddLabelSubmitToState() async* {
    try {
      // print("_mapAddLabelSubmitToState ${state.label}");
      if (state.label?.name?.isEmpty ?? true) {
        yield state.failed("Tên nhãn rỗng!");
      } else {
        await _taskRepository.addLabel(state.label);
        yield AddLabelState.success();
      }
    } catch (e) {
      yield state.failed(e.toString());
    }
  }
}
