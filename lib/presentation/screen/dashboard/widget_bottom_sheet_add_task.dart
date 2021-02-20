import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/utils/my_const/asset_const.dart';

class BottomSheetAddTask extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>();
  Task task = Task();
  final TextEditingController _textNameTaskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        // condition: (previous, current) {
        //   print("previous: $previous : current: $current");
        //   //return (previous != current) && current is AddTaskState;
        //   return
        // },
        builder: (context, state) {
          print("BUILD BOTTOM SHEET: ${state}");
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    cursorColor: Colors.black,
                    controller: _textNameTaskController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Ví Dụ: Đọc sách',
                    ),
                    onChanged: (value) {
                      task = task.copyWith(taskName: value);
                      _taskBloc.add(CanAddTaskChanged(
                          canAddTask: value?.isNotEmpty ?? false));
                    }),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconOutlineButton("No date", kIconToday, onPressed: () {}),
                    SizedBox(
                      width: 8.0,
                    ),
                    IconOutlineButton("Inbox", kIconDashboard,
                        colorIcon: Colors.blue, onPressed: () {}),
                  ],
                ),
                Row(
                  children: [
                    CircleInkWell(
                      Icons.local_offer_outlined,
                      sizeIcon: 24.0,
                    ),
                    CircleInkWell(
                      Icons.flag_outlined,
                      sizeIcon: 24.0,
                    ),
                    CircleInkWell(
                      Icons.alarm,
                      sizeIcon: 24.0,
                    ),
                    CircleInkWell(
                      Icons.mode_comment_outlined,
                      sizeIcon: 24.0,
                    ),
                    Spacer(),
                    CircleInkWell(
                      Icons.send_outlined,
                      sizeIcon: 24.0,
                      onPressed: isSendButtonActived(state)
                          ? () {
                              _taskBloc.add(AddTask(task: task));
                              _textNameTaskController.clear();
                            }
                          : null,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  bool isSendButtonActived(TaskState state) {
    if (state is DisplayListTasks) {
      return state.canAddTask;
    }
    return false;
  }
}
