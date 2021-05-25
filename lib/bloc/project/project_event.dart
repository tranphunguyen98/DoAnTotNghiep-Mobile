import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/project.dart';

abstract class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class InitProject extends AddProjectEvent {
  final Project project;

  const InitProject(this.project);

  @override
  List<Object> get props => [project];

  @override
  String toString() {
    return 'InitProject{name: $project  }';
  }
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
