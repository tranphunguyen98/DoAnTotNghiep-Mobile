import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/dropdown_choice.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/presentation/common_widgets/widget_label_container.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/util.dart';

class BottomSheetAddTask extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>();
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  final TextEditingController _textNameTaskController = TextEditingController();

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: BlocConsumer<TaskSubmitBloc, TaskSubmitState>(
        cubit: _taskSubmitBloc,
        listener: (context, state) {
          if (state.success == true) {
            _taskBloc.add(DataListTaskChanged());
            _taskSubmitBloc.add(OpenBottomSheetAddTask());
          }
        },
        builder: (context, state) {
          print("BUILD BOTTOM SHEET");
          _intData(_taskBloc.state as DisplayListTasks);
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextNameTask(state),
                if (state.taskSubmit.labels.isNotEmpty)
                  Row(
                    children: [
                      ...state.taskSubmit.labels
                          .map((e) => LabelContainer(
                                label: e,
                              ))
                          .toList()
                    ],
                  ),
                buildRowDateAndProject(context, state),
                buildRowFunction(context, state)
              ],
            ),
          );
        },
      ),
    );
  }

  TextFieldNonBorder _buildTextNameTask(TaskSubmitState state) {
    print("build text $state}");
    _textNameTaskController
      ..text = state.taskSubmit.name ?? ''
      ..selection =
          TextSelection.collapsed(offset: state.taskSubmit.name?.length ?? 0);

    return TextFieldNonBorder(
      controller: _textNameTaskController,
      onChanged: (value) {
        _taskSubmitBloc.add(TaskSubmitChanged(taskName: value));
      },
    );
  }

  void _intData(DisplayListTasks state) {
    print("State: $state}");
    dropdownChoicesProject.clear();
    dropdownChoicesProject.add(Project(name: "Inbox"));
    dropdownChoicesProject.addAll(state.listProject);

    dropdownChoicesLabel.clear();
    dropdownChoicesLabel
        .add(Label(name: "No Label", color: Util.getHexFromColor(Colors.grey)));
    dropdownChoicesLabel.addAll(state.listLabel);
  }

  void onDropdownPriorityChanged(DropdownChoice choice) {
    if (choice.title.contains("1")) {
      _taskSubmitBloc.add(TaskSubmitChanged(priority: Task.kPriority1));
    } else if (choice.title.contains("2")) {
      _taskSubmitBloc.add(TaskSubmitChanged(priority: Task.kPriority2));
    } else if (choice.title.contains("3")) {
      _taskSubmitBloc.add(TaskSubmitChanged(priority: Task.kPriority3));
    } else if (choice.title.contains("4")) {
      _taskSubmitBloc.add(TaskSubmitChanged(priority: Task.kPriority4));
    }
  }

  Row buildRowFunction(BuildContext context, TaskSubmitState state) {
    // print(state.)
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          colorIcon:
              state.taskSubmit.labels.isEmpty ? kColorBlack2 : Colors.red,
          sizeIcon: 24.0,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.kSelectLabel);
          },
        ),
        PopupMenuButton<DropdownChoice>(
          offset: Offset(0, -200),
          onSelected: (DropdownChoice choice) {
            //_textNameTaskController.text = state.taskAdd.taskName;
            onDropdownPriorityChanged(choice);
          },
          elevation: 6,
          icon: CircleInkWell(
            dropdownChoicesPriority[state.taskSubmit.priorityType - 1].iconData,
            colorIcon:
                dropdownChoicesPriority[state.taskSubmit.priorityType - 1]
                    .color,
            sizeIcon: 24.0,
          ),
          itemBuilder: (BuildContext context) {
            return dropdownChoicesPriority.map((DropdownChoice choice) {
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
          colorIcon: isSendButtonActived(state) ? Colors.red : kColorBlack2,
          onPressed: isSendButtonActived(state)
              ? () {
                  _taskSubmitBloc.add(SubmitAddTask());
                }
              : null,
        ),
      ],
    );
  }

  Row buildRowDateAndProject(BuildContext context, TaskSubmitState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconOutlineButton(
          Util.getDisplayTextDateFromDate(state.taskSubmit.taskDate ?? "") ??
              "No Date",
          Icons.calendar_today,
          colorIcon:
              state.taskSubmit.taskDate != null ? Colors.green : kColorGray1,
          colorBorder:
              state.taskSubmit.taskDate != null ? Colors.green : kColorGray1,
          onPressed: () async {
            await onPressedPickDate(context);
          },
        ),
        SizedBox(
          width: 8.0,
        ),
        PopupMenuButton<Project>(
          offset: Offset(0, -100),
          onSelected: (Project project) {
            if (project.id == null) {
              _taskSubmitBloc
                  .add(TaskSubmitChanged(project: Project(id: '', name: '')));
            } else {
              _taskSubmitBloc.add(TaskSubmitChanged(project: project));
            }
          },
          elevation: 6,
          itemBuilder: (BuildContext context) {
            return dropdownChoicesProject.map((Project project) {
              return PopupMenuItem<Project>(
                value: project,
                child: ItemPopupMenu(
                  DropdownChoice(
                      title: project.name,
                      color: Colors.red,
                      iconData: project.id?.isEmpty ?? true
                          ? Icons.inbox
                          : Icons.circle,
                      onPressed: () {}),
                ),
              );
            }).toList();
          },
          child: IgnorePointer(
            child: IconOutlineButton(
              (state.taskSubmit.project?.name?.isEmpty ?? true)
                  ? "Inbox"
                  : state.taskSubmit.project.name,
              state.taskSubmit.project?.id?.isEmpty ?? true
                  ? Icons.calendar_today
                  : Icons.circle,
              onPressed: () {},
              colorIcon: state.taskSubmit.project?.name != null
                  ? Colors.red
                  : kColorGray1,
              colorBorder: state.taskSubmit.project?.name != null
                  ? Colors.red
                  : kColorGray1,
            ),
          ),
        ),
      ],
    );
  }

  Future onPressedPickDate(BuildContext context) async {
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
      _taskSubmitBloc
          .add(TaskSubmitChanged(taskDate: picker.toIso8601String()));
    }
  }

  bool isSendButtonActived(TaskSubmitState state) {
    return state.taskSubmit.name?.isNotEmpty ?? false;
  }
}

class TextFieldNonBorder extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;
  const TextFieldNonBorder({this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        // focusNode: FocusNode(canRequestFocus: false),
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Ví Dụ: Đọc sách',
        ),
        onChanged: onChanged);
  }
}
