import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemTask extends StatelessWidget {
  final Task task;

  ItemTask(this.task);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleInkWell(
            Icons.fiber_manual_record_outlined,
          ),
          Text(
            task.taskName,
            style: kFontRegularBlack2_14,
          )
        ],
      ),
    );
  }
}
