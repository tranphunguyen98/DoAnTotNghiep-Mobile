import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenHomeScreen extends TaskEvent {}

// class OpenBottomSheetDetailTask extends TaskEvent {
//   final Task task;
//
//   OpenBottomSheetDetailTask(this.task);
//
//   @override
//   List<Object> get props => [task];
//
//   @override
//   String toString() {
//     return 'OpenBottomSheetDetailTask{task: $task}';
//   }
// }

class SelectedDrawerIndexChanged extends TaskEvent {
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

class DataLabelChanged extends TaskEvent {}

class DataProjectChanged extends TaskEvent {}

class DataListTaskChanged extends TaskEvent {}
