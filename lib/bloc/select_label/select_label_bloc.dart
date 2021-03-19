import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/data/entity/label.dart';

import 'bloc.dart';

class SelectLabelBloc extends Bloc<SelectLabelEvent, SelectLabelState> {
  final ITaskRepository _taskRepository;

  SelectLabelBloc({@required ITaskRepository taskRepository})
      : assert(taskRepository != null),
        _taskRepository = taskRepository,
        super(const SelectLabelState());

  @override
  Stream<SelectLabelState> mapEventToState(SelectLabelEvent event) async* {
    if (event is InitDataSelectLabel) {
      yield* _mapInitDataSelectedLabelToState(event.listLabelSelected);
    } else if (event is DataListLabelChanged) {
      yield* _mapDataListLabelChangedToState();
    } else if (event is AddLabelSelected) {
      yield* _mapAddLabelSelectedToState(event.label);
    } else if (event is RemoveLabelSelected) {
      yield* _mapRemoveLabelSelectedToState(event.label);
    }
  }

  Stream<SelectLabelState> _mapInitDataSelectedLabelToState(
      List<Label> listLabelSelected) async* {
    final listAllLabel = await _taskRepository.getLabels();
    yield state.copyWith(
      listAllLabel: listAllLabel,
      listLabelSelected: listLabelSelected,
    );
  }

  Stream<SelectLabelState> _mapDataListLabelChangedToState() async* {
    try {
      final listLabel = await _taskRepository.getLabels();

      yield state.copyWith(listAllLabel: listLabel);
    } catch (e) {
      yield state.copyWith(error: e.toString());
    }
  }

  Stream<SelectLabelState> _mapAddLabelSelectedToState(Label label) async* {
    final List<Label> newList = <Label>[];
    newList.addAll(state.listLabelSelected);
    newList.add(label);

    yield state.copyWith(listLabelSelected: newList);
  }

  Stream<SelectLabelState> _mapRemoveLabelSelectedToState(Label label) async* {
    final List<Label> newList = <Label>[];
    newList.addAll(state.listLabelSelected);
    newList.remove(label);

    yield state.copyWith(listLabelSelected: newList);
  }
}
