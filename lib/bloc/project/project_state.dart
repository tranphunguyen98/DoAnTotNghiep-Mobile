import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/project.dart';

@immutable
class AddProjectState extends Equatable {
  final Project project;
  final String msg;
  final bool isSuccess;

  const AddProjectState({
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
  }) {
    if ((project == null || identical(project, this.project)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess))) {
      return this;
    }

    return AddProjectState(
      project: project ?? this.project,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'AddProjectState{project: $project, msg: $msg, isSuccess: $isSuccess}';
  }

  @override
  // TODO: implement props
  List<Object> get props => [project, msg, isSuccess];
}
