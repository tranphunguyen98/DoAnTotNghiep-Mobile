import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/presentation/screen/task/widget_row_checkbox_name_task.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ItemTask extends StatelessWidget {
  final Task task;
  final Function(Task task) updateTask;
  final Function(Task task) onPressed;

  const ItemTask({Key key, this.task, this.updateTask, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(task);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowCheckBoxAndNameTask(task: task, updateTask: updateTask),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Row(
                    children: [
                      if (task.taskDate != null) buildRowDate(task.taskDate),
                      const SizedBox(
                        width: 8.0,
                      ),
                      if ((task.labels?.isEmpty ?? true) &&
                          !(task.checkList?.isEmpty ?? true))
                        buildRowCheckList(),
                      const Spacer(),
                      if (task.labels?.isEmpty ?? true) buildRowProject()
                    ],
                  ),
                ),
                if (!(task.labels?.isEmpty ?? true))
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Row(
                      children: [
                        if (!(task.checkList?.isEmpty ?? true))
                          buildRowCheckList(),
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
                        const Spacer(),
                        buildRowProject(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
            height: 1.0,
          )
        ],
      ),
    );
  }

  Row buildRowCheckList() {
    return Row(
      children: [
        Icon(
          Icons.fact_check_rounded,
          size: 12.0,
          color: kColorGray1,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          "${task.checkList.where((element) => element.isDone).length}/${task.checkList.length}",
          style: kFontRegularGray1_12,
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }

  Row buildRowProject() {
    return Row(
      children: [
        Text(
          task.project?.name?.isEmpty ?? true ? "Inbox" : task.project.name,
          style: kFontRegular.copyWith(
            fontSize: 12,
            color: kColorGray1,
          ),
        ),
        const SizedBox(
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
    );
  }

  Row buildRowDate(String taskDate) {
    final displayTextDate =
        DateHelper.getDisplayTextDateFromDate(task.taskDate);
    final isOverDue = DateHelper.isOverDueString(task.taskDate);
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 12.0,
          color: isOverDue ? Colors.red : Colors.green,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          displayTextDate,
          style: kFontRegular.copyWith(
            fontSize: 12,
            color: isOverDue ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
