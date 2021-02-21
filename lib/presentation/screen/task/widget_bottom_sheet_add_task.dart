import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/dropdown_choice.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/utils/my_const/asset_const.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/util.dart';

class BottomSheetAddTask extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>();
  final TextEditingController _textNameTaskController = TextEditingController();
  final FocusNode _focusNode = FocusNode(canRequestFocus: false);
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
          print("current: ${(current as DisplayListTasks).taskAdd}");
          bool canBuild = current is DisplayListTasks &&
              previous is DisplayListTasks &&
              (previous.taskAdd.taskName.isNotEmpty !=
                      current.taskAdd.taskName.isNotEmpty ||
                  previous.taskAdd.priorityType !=
                      current.taskAdd.priorityType ||
                  (previous.taskAdd.taskDate ?? "") !=
                      current.taskAdd.taskDate);
          print("canBuild ${canBuild}");
          return canBuild;
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
                buildRowDateAndProject(context, state as DisplayListTasks),
                buildRowFunction(state as DisplayListTasks)
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildRowFunction(DisplayListTasks state) {
    // print(state.)
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          sizeIcon: 24.0,
        ),
        PopupMenuButton<DropdownChoice>(
          offset: Offset(0, -300),
          onSelected: (DropdownChoice choice) {
            //_textNameTaskController.text = state.taskAdd.taskName;
            if (choice.title.contains("1")) {
              _taskBloc.add(TaskAddChanged(priority: Task.kPriority1));
            } else if (choice.title.contains("2")) {
              _taskBloc.add(TaskAddChanged(priority: Task.kPriority2));
            } else if (choice.title.contains("3")) {
              _taskBloc.add(TaskAddChanged(priority: Task.kPriority3));
            } else if (choice.title.contains("4")) {
              _taskBloc.add(TaskAddChanged(priority: Task.kPriority4));
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

  String getDisplayTextDateFromDate(String dateTime) {
    if (dateTime.isNotEmpty) {
      final date = DateTime.parse(dateTime);
      if (date.compareTo(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          )) ==
          0) {
        return "To Day";
      } else {
        return DateFormat("dd/MM/yyyy").format(date);
      }
    }
    return "No Date";
  }

  Row buildRowDateAndProject(BuildContext context, DisplayListTasks state) {
    print("state: date: ${state.taskAdd}");

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconOutlineButton(
          Util.getDisplayTextDateFromDate(state.taskAdd.taskDate ?? "") ??
              "No Date",
          kIconToday,
          colorIcon:
              state.taskAdd.taskDate != null ? Colors.green : kColorGray1,
          colorBorder:
              state.taskAdd.taskDate != null ? Colors.green : kColorGray1,
          onPressed: () async {
            print("canRequestFocus: ${_focusNode.canRequestFocus}");
            _focusNode.canRequestFocus = true;
            print("canRequestFocus: ${_focusNode.canRequestFocus}");
            FocusScope.of(context).unfocus();
            final picker = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
              ),
              lastDate: DateTime(2100),
            );
            if (picker != null) {
              print("date: ${picker.toIso8601String()}");
              _taskBloc.add(TaskAddChanged(taskDate: picker.toIso8601String()));
              //  _focusNode.canRequestFocus = false;
              //   _focusNode.requestFocus();

            }
          },
        ),
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
      focusNode: _focusNode,
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: 'Ví Dụ: Đọc sách',
      ),
      onChanged: (value) {
        _taskBloc.add(TaskAddChanged(taskName: value));
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
