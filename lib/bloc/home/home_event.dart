import 'package:equatable/equatable.dart';
import 'package:totodo/data/entity/task.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends HomeEvent {}

class SelectedDrawerIndexChanged extends HomeEvent {
  final int index;
  final int type;
  final int id;

  SelectedDrawerIndexChanged({this.index, this.type, this.id});

  @override
  List<Object> get props => [index, type, id];

  @override
  String toString() {
    return 'SelectedDrawerIndexChanged{index: $index, type: $type, id: $id}';
  }
}

class SelectedBottomNavigationIndexChanged extends HomeEvent {
  final int index;

  SelectedBottomNavigationIndexChanged(this.index);

  @override
  List<Object> get props => [index];

  @override
  String toString() {
    return 'SelectedBottomNavigationIndexChanged{index: $index}';
  }
}

class UpdateTaskEvent extends HomeEvent {
  final Task task;

  UpdateTaskEvent([this.task]);

  @override
  List<Object> get props => [task];

  @override
  String toString() {
    return 'UpdateTaskEvent{task: $task}';
  }
}

class DataListLabelChanged extends HomeEvent {}

class DataProjectChanged extends HomeEvent {}

class DataListTaskChanged extends HomeEvent {}

class DataListSectionChanged extends HomeEvent {}
