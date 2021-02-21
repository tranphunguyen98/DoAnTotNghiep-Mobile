import 'package:flutter/material.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_item_task.dart';

class ListTask extends StatelessWidget {
  final List<Task> listTask;
  final TaskBloc _taskBloc = getIt<TaskBloc>();
  ListTask(this.listTask);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        return ItemTask(listTask[index], (task) {
          _taskBloc.add(TaskUpdated(task: task));
        });
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1.0,
        );
      },
      itemCount: listTask.length,
      physics: BouncingScrollPhysics(),
    );
  }
}
