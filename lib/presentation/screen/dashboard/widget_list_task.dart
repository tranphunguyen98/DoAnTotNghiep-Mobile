import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/dashboard/widget_item_task.dart';

class ListTask extends StatelessWidget {
  final List<Task> listTask;

  ListTask(this.listTask);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        return ItemTask(listTask[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: listTask.length,
      physics: BouncingScrollPhysics(),
    );
  }
}
