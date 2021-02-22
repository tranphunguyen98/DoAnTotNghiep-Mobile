import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/util.dart';

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
    final displayTextDate = Util.getDisplayTextDateFromDate(task.taskDate);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor:
                        listColorPriority[task.priorityType - 1],
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
                      activeColor: listColorPriority[task.priorityType - 1],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    task.taskName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: task.isCompleted
                        ? kFontRegularGray1_14
                        : kFontRegularBlack2_14,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  if (displayTextDate != null)
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12.0,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          displayTextDate,
                          style: kFontRegular.copyWith(
                              fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        task.projectName?.isEmpty ?? true
                            ? "Inbox"
                            : task.projectName,
                        style: kFontRegular.copyWith(
                          fontSize: 12,
                          color: kColorGray1,
                        ),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Icon(
                        Icons.circle,
                        size: 12.0,
                        color: kColorGray4,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
