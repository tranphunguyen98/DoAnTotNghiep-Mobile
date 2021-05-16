import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/section.dart';

@immutable
class AddSectionState extends Equatable {
  final Section section;
  final String projectId;
  final bool isValidNameSection;
  final String msg;
  final bool isSuccess;

  const AddSectionState({
    this.section = Section.kSectionEmpty,
    this.projectId,
    this.msg,
    this.isValidNameSection = false,
    this.isSuccess = false,
  });

  AddSectionState updateSection(Section section) {
    return copyWith(
      section: section,
    );
  }

  AddSectionState failed(String msg) {
    return AddSectionState(msg: msg, section: section);
  }

  AddSectionState copyWith({
    Section section,
    String projectId,
    bool isValidNameSection,
    String msg,
    bool isSuccess,
  }) {
    if ((section == null || identical(section, this.section)) &&
        (projectId == null || identical(projectId, this.projectId)) &&
        (isValidNameSection == null ||
            identical(isValidNameSection, this.isValidNameSection)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess))) {
      return this;
    }

    return AddSectionState(
      section: section ?? this.section,
      projectId: projectId ?? this.projectId,
      isValidNameSection: isValidNameSection ?? this.isValidNameSection,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'AddSectionState{section: $section, projectId: $projectId, isValidNameSection: $isValidNameSection, msg: $msg, isSuccess: $isSuccess}';
  }

  @override
  List<Object> get props =>
      [section, projectId, msg, isSuccess, isValidNameSection];
}
