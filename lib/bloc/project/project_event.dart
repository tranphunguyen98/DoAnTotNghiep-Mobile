import 'package:equatable/equatable.dart';

abstract class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class AddedProjectChanged extends AddProjectEvent {
  final String name;
  final String color;

  const AddedProjectChanged({this.name, this.color});

  @override
  List<Object> get props => [name, color];

  @override
  String toString() {
    return 'AddedProjectChanged{nameProject: $name, color: $color}';
  }
}

class AddProjectSubmit extends AddProjectEvent {}
