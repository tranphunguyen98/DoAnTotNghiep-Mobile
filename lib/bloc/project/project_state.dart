import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/project.dart';

@immutable
class AddProjectState extends Equatable {
  final Project project;
  final String msg;
  final bool isSuccess;
  final bool isProjectNameValid;

  const AddProjectState({
    this.isProjectNameValid = true,
    this.project = const Project(),
    this.msg,
    this.isSuccess = false,
  });

  AddProjectState updateProject(Project project) {
    return copyWith(project: project);
  }

  factory AddProjectState.success() {
    return const AddProjectState(isSuccess: true);
  }

  AddProjectState failed(String msg) {
    return AddProjectState(msg: msg, project: project);
  }

  AddProjectState copyWith({
    Project project,
    String msg,
    bool isSuccess,
    bool isProjectNameValid,
  }) {
    if ((project == null || identical(project, this.project)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess)) &&
        (isProjectNameValid == null ||
            identical(isProjectNameValid, this.isProjectNameValid))) {
      return this;
    }

    return AddProjectState(
      project: project ?? this.project,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
      isProjectNameValid: isProjectNameValid ?? this.isProjectNameValid,
    );
  }

  @override
  String toString() {
    return 'AddProjectState{project: $project, msg: $msg, isSuccess: $isSuccess, isProjectNameValid: $isProjectNameValid}';
  }

  @override
  List<Object> get props => [project, msg, isSuccess, isProjectNameValid];
}
