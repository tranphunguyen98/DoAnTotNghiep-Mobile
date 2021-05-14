import 'package:equatable/equatable.dart';

abstract class AddLabelEvent extends Equatable {
  const AddLabelEvent();

  @override
  List<Object> get props => [];
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
