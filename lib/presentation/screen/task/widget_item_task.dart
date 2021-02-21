import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemTask extends StatelessWidget {
  final Task task;
  final Function(Task task) updateTask;
  final listColorPriority = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    kColorGray1
  ];

  ItemTask(this.task, this.updateTask);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          // CircleInkWell(
          //   Icons.fiber_manual_record_outlined,
          //   colorIcon: listColorPriority[task.priorityType - 1],
          // ),
          Theme(
            data: ThemeData(
                unselectedWidgetColor:
                    listColorPriority[task.priorityType - 1]),
            child: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                updateTask(task.copyWith(isCompleted: value));
              },
              checkColor: Colors.white,
              activeColor: listColorPriority[task.priorityType - 1],
              // focusColor: listColorPriority[task.priorityType - 1],
              // hoverColor: listColorPriority[task.priorityType - 1],
            ),
          ),
          Text(
            task.taskName,
            style:
                task.isCompleted ? kFontRegularGray1_14 : kFontRegularBlack2_14,
          )
        ],
      ),
    );
  }
}
