import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddProjectEvent extends Equatable {
  const AddProjectEvent();

  @override
  List<Object> get props => [];
}

class NameProjectChanged extends AddProjectEvent {
  final String nameProject;

  const NameProjectChanged({@required this.nameProject});

  @override
  List<Object> get props => [nameProject];

  @override
  String toString() {
    return 'NameProjectChanged{nameProject: $nameProject}';
  }
}

class AddProjectSubmit extends AddProjectEvent {}

class OpenAddProjectEvent extends AddProjectEvent {}
