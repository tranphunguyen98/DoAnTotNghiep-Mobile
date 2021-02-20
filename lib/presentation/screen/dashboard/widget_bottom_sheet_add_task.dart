import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/dropdown_choice.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/utils/my_const/asset_const.dart';

class BottomSheetAddTask extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>();
  final TextEditingController _textNameTaskController = TextEditingController();

  final List<DropdownChoice> dropdownChoices = [
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.red,
        title: "Priority 1",
        onPressed: () {}),
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.orange,
        title: "Priority 2",
        onPressed: () {}),
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.blue,
        title: "Priority 3",
        onPressed: () {}),
    DropdownChoice(
        iconData: Icons.flag_outlined, title: "Priority 4", onPressed: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: BlocBuilder<TaskBloc, TaskState>(
        cubit: _taskBloc,
        buildWhen: (previous, current) {
          return current is DisplayListTasks &&
              previous is DisplayListTasks &&
              previous.taskAdd.taskName.isNotEmpty !=
                  current.taskAdd.taskName.isNotEmpty;
        },
        builder: (context, state) {
          print("BUILD BOTTOM SHEET");
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFieldNameTask(state as DisplayListTasks),
                buildRowDateAndProject(),
                buildRowFunction(state as DisplayListTasks)
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildRowFunction(DisplayListTasks state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          sizeIcon: 24.0,
        ),
        // CircleInkWell(
        //   Icons.flag_outlined,
        //   sizeIcon: 24.0,
        // ),
        PopupMenuButton<DropdownChoice>(
          onSelected: (DropdownChoice choice) {
            _textNameTaskController.text = state.taskAdd.taskName;
            if (choice.title.contains("1")) {
              _taskBloc.add(TaskChanged(
                  taskAdd:
                      state.taskAdd.copyWith(priorityType: Task.kPriority1)));
            } else if (choice.title.contains("2")) {
              _taskBloc.add(TaskChanged(
                  taskAdd:
                      state.taskAdd.copyWith(priorityType: Task.kPriority2)));
            } else if (choice.title.contains("3")) {
              _taskBloc.add(TaskChanged(
                  taskAdd:
                      state.taskAdd.copyWith(priorityType: Task.kPriority3)));
            } else if (choice.title.contains("4")) {
              _taskBloc.add(TaskChanged(
                  taskAdd:
                      state.taskAdd.copyWith(priorityType: Task.kPriority4)));
            }
          },
          elevation: 6,
          icon: CircleInkWell(
            dropdownChoices[state.taskAdd.priorityType - 1].iconData,
            colorIcon: dropdownChoices[state.taskAdd.priorityType - 1].color,
            sizeIcon: 24.0,
          ),
          itemBuilder: (BuildContext context) {
            return dropdownChoices.map((DropdownChoice choice) {
              return PopupMenuItem<DropdownChoice>(
                value: choice,
                child: ItemPopupMenu(choice),
              );
            }).toList();
          },
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
                  _taskBloc.add(AddTask());
                  _textNameTaskController.clear();
                }
              : null,
        ),
      ],
    );
  }

  Row buildRowDateAndProject() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconOutlineButton("No date", kIconToday, onPressed: () {}),
        SizedBox(
          width: 8.0,
        ),
        IconOutlineButton("Inbox", kIconDashboard,
            colorIcon: Colors.blue, onPressed: () {}),
      ],
    );
  }

  TextFormField buildTextFieldNameTask(DisplayListTasks state) {
    _textNameTaskController
      ..text = state.taskAdd.taskName
      ..selection =
          TextSelection.collapsed(offset: state.taskAdd.taskName.length);
    return TextFormField(
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
        _taskBloc
            .add(TaskChanged(taskAdd: state.taskAdd.copyWith(taskName: value)));
      },
    );
  }

  bool isSendButtonActived(TaskState state) {
    if (state is DisplayListTasks) {
      return state.taskAdd.taskName.isNotEmpty;
    }
    return false;
  }
}
