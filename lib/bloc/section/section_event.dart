import 'package:equatable/equatable.dart';

abstract class AddSectionEvent extends Equatable {
  const AddSectionEvent();

  @override
  List<Object> get props => [];
}

class NameSectionAddChanged extends AddSectionEvent {
  final String name;

  const NameSectionAddChanged({this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'AddedSectionChanged{nameSection: $name}';
  }
}

class ProjectIdSectionAddChanged extends AddSectionEvent {
  final String projectId;

  const ProjectIdSectionAddChanged({this.projectId});

  @override
  List<Object> get props => [projectId];

  @override
  String toString() {
    return 'ProjectIdSectionAddChanged{projectId: $projectId}';
  }
}

class AddSectionSubmit extends AddSectionEvent {}

class OpenAddSectionEvent extends AddSectionEvent {}
