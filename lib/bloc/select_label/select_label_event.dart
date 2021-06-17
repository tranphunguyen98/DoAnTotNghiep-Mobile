import 'package:equatable/equatable.dart';
import 'package:totodo/data/model/label.dart';

abstract class SelectLabelEvent extends Equatable {
  const SelectLabelEvent();

  @override
  List<Object> get props => [];
}

class InitDataSelectLabel extends SelectLabelEvent {
  final List<Label> listLabelSelected;

  const InitDataSelectLabel({this.listLabelSelected});

  @override
  List<Object> get props => [listLabelSelected];

  @override
  String toString() {
    return 'InitDataSelectedLabel{listLabelSelected: $listLabelSelected}';
  }
}

class AddLabelSelected extends SelectLabelEvent {
  final Label label;

  const AddLabelSelected({this.label});

  @override
  List<Object> get props => [label];

  @override
  String toString() {
    return 'AddLabelSelected{label: $label}';
  }
}

class RemoveLabelSelected extends SelectLabelEvent {
  final Label label;

  const RemoveLabelSelected({this.label});

  @override
  List<Object> get props => [label];

  @override
  String toString() {
    return 'RemoveLabelSelected{label: $label}';
  }
}

class DataListLabelChanged extends SelectLabelEvent {}
