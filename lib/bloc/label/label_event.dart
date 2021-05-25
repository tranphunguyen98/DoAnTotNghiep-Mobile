import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/label.dart';

abstract class AddLabelEvent extends Equatable {
  const AddLabelEvent();

  @override
  List<Object> get props => [];
}

class InitLabel extends AddLabelEvent {
  final Label label;

  const InitLabel(this.label);

  @override
  List<Object> get props => [label];

  @override
  String toString() {
    return 'InitLabel{name: $label  }';
  }
}

class AddedLabelChanged extends AddLabelEvent {
  final String name;
  final String color;

  const AddedLabelChanged({this.name, this.color});

  @override
  List<Object> get props => [name, color];

  @override
  String toString() {
    return 'NameLabelChanged{name: $name + $color}';
  }
}

class AddLabelSubmit extends AddLabelEvent {}
