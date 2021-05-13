import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/section_display.dart';

@immutable
class AddSectionState extends Equatable {
  final SectionDisplay section;
  final bool isValidNameSection;
  final String msg;
  final bool isSuccess;

  const AddSectionState({
    this.section = SectionDisplay.kSectionEmpty,
    this.msg,
    this.isValidNameSection = false,
    this.isSuccess = false,
  });

  AddSectionState updateSection(SectionDisplay section) {
    return copyWith(section: section);
  }

  factory AddSectionState.success() {
    return const AddSectionState(isSuccess: true);
  }

  AddSectionState failed(String msg) {
    return AddSectionState(msg: msg, section: section);
  }

  AddSectionState copyWith({
    SectionDisplay section,
    bool isValidNameSection,
    String msg,
    bool isSuccess,
  }) {
    if ((section == null || identical(section, this.section)) &&
        (isValidNameSection == null ||
            identical(isValidNameSection, this.isValidNameSection)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess))) {
      return this;
    }

    return AddSectionState(
      section: section ?? this.section,
      isValidNameSection: isValidNameSection ?? this.isValidNameSection,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'AddSectionState{section: $section, msg: $msg, isSuccess: $isSuccess}';
  }

  @override
  List<Object> get props => [section, msg, isSuccess, isValidNameSection];
}
