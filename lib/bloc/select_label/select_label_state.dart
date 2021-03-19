import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:totodo/data/entity/label.dart';

@immutable
class SelectLabelState extends Equatable {
  final List<Label> listAllLabel;
  final List<Label> listLabelSelected;
  final String error;

  const SelectLabelState(
      {this.listAllLabel = const [],
      this.listLabelSelected = const [],
      this.error});

  SelectLabelState updateListLabelSelected(List<Label> listLabelSelected) {
    return copyWith(listLabelSelected: listLabelSelected);
  }

  SelectLabelState copyWith({
    List<Label> listAllLabel,
    List<Label> listLabelSelected,
    String error,
  }) {
    if ((listAllLabel == null || identical(listAllLabel, this.listAllLabel)) &&
        (listLabelSelected == null ||
            identical(listLabelSelected, this.listLabelSelected)) &&
        (error == null || identical(error, this.error))) {
      return this;
    }

    return SelectLabelState(
      listAllLabel: listAllLabel ?? this.listAllLabel,
      listLabelSelected: listLabelSelected ?? this.listLabelSelected,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'SelectLabelState{listAllLabel: $listAllLabel, listLabelSelected: $listLabelSelected, error: $error}';
  }

  @override
  List<Object> get props => [listAllLabel, listLabelSelected, error];
}
