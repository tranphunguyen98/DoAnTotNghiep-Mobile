import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/presentation/screen/task/widget_row_checkbox_name_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class ItemTask extends StatelessWidget {
  final Task task;
  final Function(Task task) updateTask;
  final Function(Task task) onPressed;

  ItemTask(this.task, this.updateTask, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    final displayTextDate = Util.getDisplayTextDateFromDate(task.taskDate);
    return InkWell(
      onTap: () {
        onPressed(task);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowCheckBoxAndNameTask(task: task, updateTask: updateTask),
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
                  if (task.labels?.isEmpty ?? true)
                    Row(
                      children: [
                        Text(
                          task.project?.name?.isEmpty ?? true
                              ? "Inbox"
                              : task.project.name,
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
                          color: task.project?.color?.isEmpty ?? true
                              ? kColorGray4
                              : HexColor(task.project.color),
                        ),
                      ],
                    )
                ],
              ),
            ),
            if (!(task.labels?.isEmpty ?? true))
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  children: [
                    ...task.labels
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              e.name,
                              style: kFontRegular.copyWith(
                                  fontSize: 12, color: HexColor(e.color)),
                            ),
                          ),
                        )
                        .toList(),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          task.project?.name?.isEmpty ?? true
                              ? "Inbox"
                              : task.project.name,
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
                          color: task.project?.color?.isEmpty ?? true
                              ? kColorGray4
                              : HexColor(task.project.color),
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
