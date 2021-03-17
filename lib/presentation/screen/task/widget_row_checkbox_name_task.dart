import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class RowCheckBoxAndNameTask extends StatelessWidget {
  const RowCheckBoxAndNameTask({
    Key key,
    @required this.task,
    @required this.updateTask,
  }) : super(key: key);

  final Task task;
  final Function(Task task) updateTask;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor: kListColorPriority[task.priorityType - 1],
          ),
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                updateTask(task.copyWith(isCompleted: value));
              },
              checkColor: Colors.white,
              activeColor: kListColorPriority[task.priorityType - 1],
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            task.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
                task.isCompleted ? kFontRegularGray1_14 : kFontRegularBlack2_14,
          ),
        ),
      ],
    );
  }
}
