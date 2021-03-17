import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/utils/util.dart';

import '../../../bloc/submit_task/bloc.dart';
import '../../../bloc/task/bloc.dart';
import '../../../data/entity/label.dart';
import '../../../data/entity/project.dart';
import '../../../data/entity/task.dart';
import '../../../di/injection.dart';
import '../../../utils/date_helper.dart';
import '../../../utils/my_const/color_const.dart';
import '../../common_widgets/dropdown_choice.dart';
import '../../common_widgets/widget_circle_inkwell.dart';
import '../../common_widgets/widget_icon_outline_button.dart';
import '../../common_widgets/widget_item_popup_menu.dart';
import '../../common_widgets/widget_label_container.dart';
import '../../common_widgets/widget_text_field_non_border.dart';
import '../../custom_ui/custom_ui.dart';
import '../../custom_ui/date_picker/custom_picker_dialog.dart';
import '../../router.dart';

class BottomSheetAddTask extends StatelessWidget {
  final String sectionId;

  BottomSheetAddTask({this.sectionId});

  final TaskBloc _taskBloc = getIt<TaskBloc>();
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  final TextEditingController _textNameTaskController = TextEditingController();

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  @override
  Widget build(BuildContext context) {
    if ((_taskBloc.state as DisplayListTasks).checkIsInProject()) {
      _taskSubmitBloc.add(TaskSubmitChanged(
          sectionId: sectionId,
          project: (_taskBloc.state as DisplayListTasks).getProjectSelected()));
    }

    return BlocConsumer<TaskSubmitBloc, TaskSubmitState>(
      cubit: _taskSubmitBloc,
      listener: (context, state) {
        if (state.success == true) {
          _taskBloc.add(DataListTaskChanged());
          _taskSubmitBloc.add(OpenBottomSheetAddTask());
        }
      },
      builder: (context, state) {
        _intData(_taskBloc.state as DisplayListTasks);
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextNameTask(state),
              if (!(state.taskSubmit.labels?.isEmpty ?? true))
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
    );
  }

  TextFieldNonBorder _buildTextNameTask(TaskSubmitState state) {
    // print("build text $state}");
    _textNameTaskController
      ..text = state.taskSubmit.name ?? ''
      ..selection =
          TextSelection.collapsed(offset: state.taskSubmit.name?.length ?? 0);

    return TextFieldNonBorder(
      hint: 'Ví dụ: Đọc sách',
      controller: _textNameTaskController,
      onChanged: (value) {
        _taskSubmitBloc.add(TaskSubmitChanged(taskName: value));
      },
    );
  }

  void _intData(DisplayListTasks state) {
    // print("State: $state}");
    dropdownChoicesProject.clear();
    dropdownChoicesProject.add(const Project(name: "Inbox"));
    dropdownChoicesProject.addAll(state.listProject);

    dropdownChoicesLabel.clear();
    dropdownChoicesLabel
        .add(Label(name: "No Label", color: getHexFromColor(Colors.grey)));
    dropdownChoicesLabel.addAll(state.listLabel);
  }

  void _onDropdownPriorityChanged(DropdownChoice choice) {
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
          colorIcon: state.taskSubmit.labels?.isEmpty ?? true
              ? kColorBlack2
              : Colors.red,
          sizeIcon: 24.0,
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.kSelectLabel);
          },
        ),
        PopupMenuButton<DropdownChoice>(
          offset: const Offset(0, -200),
          onSelected: _onDropdownPriorityChanged,
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
        const CircleInkWell(
          Icons.alarm,
          sizeIcon: 24.0,
        ),
        const CircleInkWell(
          Icons.mode_comment_outlined,
          sizeIcon: 24.0,
        ),
        const Spacer(),
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
          DateHelper.getDisplayTextDateFromDate(
                  state.taskSubmit.taskDate ?? "") ??
              "No Date",
          Icons.calendar_today,
          colorIcon:
              state.taskSubmit.taskDate != null ? Colors.green : kColorGray1,
          colorBorder:
              state.taskSubmit.taskDate != null ? Colors.green : kColorGray1,
          onPressed: () async {
            await onPressedPickDate(context, state);
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        PopupMenuButton<Project>(
          offset: const Offset(0, -100),
          onSelected: (Project project) {
            if (project.id == null) {
              _taskSubmitBloc.add(
                  TaskSubmitChanged(project: const Project(id: '', name: '')));
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
                    color: project.color?.isEmpty ?? true
                        ? kColorGray1
                        : HexColor(project.color),
                    iconData: project.id?.isEmpty ?? true
                        ? Icons.inbox
                        : Icons.circle,
                  ),
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
              colorIcon: state.taskSubmit.project?.color?.isEmpty ?? true
                  ? kColorGray1
                  : HexColor(state.taskSubmit.project.color),
              colorBorder: state.taskSubmit.project?.color?.isEmpty ?? true
                  ? kColorGray1
                  : HexColor(state.taskSubmit.project.color),
            ),
          ),
        ),
      ],
    );
  }

  Future onPressedPickDate(BuildContext context, TaskSubmitState state) async {
    final picker = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        lastDate: DateTime(2100),
        selectedTimeOfDay:
            DateHelper.getTimeOfDayFromDateString(state.taskSubmit.taskDate));
    if (picker != null) {
      _taskSubmitBloc
          .add(TaskSubmitChanged(taskDate: picker.toIso8601String()));
    }
  }

  bool isSendButtonActived(TaskSubmitState state) {
    return state.taskSubmit.name?.isNotEmpty ?? false;
  }
}
