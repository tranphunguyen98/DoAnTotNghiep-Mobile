import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/model/label.dart';

@immutable
class AddLabelState extends Equatable {
  final Label label;
  final String msg;
  final bool isSuccess;

  const AddLabelState({
    this.label = const Label(),
    this.msg,
    this.isSuccess = false,
  });

  AddLabelState updateLabel(Label label) {
    return copyWith(label: label);
  }

  factory AddLabelState.success() {
    return const AddLabelState(isSuccess: true);
  }

  AddLabelState failed(String msg) {
    return AddLabelState(msg: msg, label: label);
  }

  AddLabelState copyWith({
    Label label,
    String msg,
    bool isSuccess,
  }) {
    if ((label == null || identical(label, this.label)) &&
        (msg == null || identical(msg, this.msg)) &&
        (isSuccess == null || identical(isSuccess, this.isSuccess))) {
      return this;
    }

    return AddLabelState(
      label: label ?? this.label,
      msg: msg ?? this.msg,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  String toString() {
    return 'AddLabelState{label: $label, msg: $msg, isSuccess: $isSuccess}';
  }

  @override
  List<Object> get props => [label, msg, isSuccess];
}
