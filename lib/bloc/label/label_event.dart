import 'package:equatable/equatable.dart';

abstract class AddLabelEvent extends Equatable {
  const AddLabelEvent();

  @override
  List<Object> get props => [];
}

class AddedLabelChanged extends AddLabelEvent {
  final String nameLabel;
  final String color;

  const AddedLabelChanged({this.nameLabel, this.color});

  @override
  List<Object> get props => [nameLabel, color];

  @override
  String toString() {
    return 'NameLabelChanged{nameLabel: $nameLabel + $color}';
  }
}

class AddLabelSubmit extends AddLabelEvent {}
