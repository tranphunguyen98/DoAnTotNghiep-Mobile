import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/presentation/screen/task/widget_row_checkbox_name_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

// class ItemTaskReorder extends StatelessWidget {
//   const ItemTaskReorder({
//     this.data,
//     this.isFirst,
//     this.isLast,
//     this.draggingMode,
//     this.updateTask,
//     this.onPressed,
//   });
//
//   final Task data;
//   final Function(Task task) updateTask;
//   final Function(Task task) onPressed;
//   final bool isFirst;
//   final bool isLast;
//   final DraggingMode draggingMode;
//
//   Widget _buildChild(BuildContext context, ReorderableItemState state) {
//     BoxDecoration decoration;
//
//     if (state == ReorderableItemState.dragProxy ||
//         state == ReorderableItemState.dragProxyFinished) {
//       // slightly transparent background white dragging (just like on iOS)
//       decoration = BoxDecoration(
//         color: Color(0xD0FFFFFF),
//       );
//     } else {
//       bool placeholder = state == ReorderableItemState.placeholder;
//       decoration = BoxDecoration(
//           border: Border(
//               top: isFirst && !placeholder
//                   ? Divider.createBorderSide(context) //
//                   : BorderSide.none,
//               bottom: isLast && placeholder
//                   ? BorderSide.none //
//                   : Divider.createBorderSide(context)),
//           color: placeholder ? null : Colors.white);
//     }
//
//     // For iOS dragging mode, there will be drag handle on the right that triggers
//     // reordering; For android mode it will be just an empty container
//     Widget dragHandle = draggingMode == DraggingMode.iOS
//         ? ReorderableListener(
//             child: Container(
//               padding: EdgeInsets.only(right: 18.0, left: 18.0),
//               color: Color(0x08000000),
//               child: Center(
//                 child: Icon(Icons.reorder, color: Color(0xFF888888)),
//               ),
//             ),
//           )
//         : Container();
//
//     Widget content = Material(
//       elevation: 10,
//       child: Container(
//         decoration: decoration,
//         child: SafeArea(
//             top: false,
//             bottom: false,
//             child: Opacity(
//               // hide content for placeholder
//               opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
//               child: IntrinsicHeight(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Expanded(
//                         child: ItemTask(
//                       onPressed: onPressed,
//                       updateTask: updateTask,
//                       task: data,
//                     )),
//                     // Triggers the reordering
//                     dragHandle,
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//
//     // For android dragging mode, wrap the entire content in DelayedReorderableListener
//     if (draggingMode == DraggingMode.Android) {
//       content = DelayedReorderableListener(
//         child: content,
//       );
//     }
//
//     return content;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ReorderableItem(
//         key: ValueKey(data.id), //
//         childBuilder: _buildChild);
//   }
// }

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
                      SizedBox(
                        width: 8.0,
                      ),
                      if ((task.labels?.isEmpty ?? true) &&
                          !(task.checkList?.isEmpty ?? true))
                        buildRowCheckList(),
                      Spacer(),
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
                        Spacer(),
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
        SizedBox(
          width: 4.0,
        ),
        Text(
          "${task.checkList.where((element) => element.isCheck).length}/${task.checkList.length}",
          style: kFontRegularGray1_12,
        ),
        SizedBox(
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
    );
  }

  Row buildRowDate(String taskDate) {
    final displayTextDate = Util.getDisplayTextDateFromDate(task.taskDate);
    final isOverDue = Util.isOverDueString(task.taskDate);
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 12.0,
          color: isOverDue ? Colors.red : Colors.green,
        ),
        SizedBox(
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
