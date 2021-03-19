import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/add_task/bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/dropdown_choice.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/presentation/common_widgets/widget_label_container.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/presentation/custom_ui/date_picker/custom_picker_dialog.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

import '../../router.dart';

class BottomSheetAddTask extends StatefulWidget {
  final String sectionId;

  const BottomSheetAddTask({this.sectionId});

  @override
  _BottomSheetAddTaskState createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTask> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  final TextEditingController _textNameTaskController = TextEditingController();

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  TaskAddBloc _taskAdd;

  @override
  void initState() {
    _taskAdd = BlocProvider.of<TaskAddBloc>(context);
    _initDataTask();
    _intDataUI(_homeBloc.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskAddBloc, TaskAddState>(
      listener: (context, state) {
        if (state.success == true) {
          _homeBloc.add(DataListTaskChanged());
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextNameTask(state),
                if (!(state.taskAdd.labels?.isEmpty ?? true))
                  Row(
                    children: [
                      ...state.taskAdd.labels
                          .map((e) => LabelContainer(
                                label: e,
                              ))
                          .toList()
                    ],
                  ),
                buildRowDateAndProject(state),
                buildRowFunction(state)
              ],
            ),
          ),
        );
      },
    );
  }

  void _initDataTask() {
    if ((_homeBloc.state).checkIsInProject()) {
      _taskAdd.add(
        TaskAddChanged(
          sectionId: widget.sectionId,
          project: (_homeBloc.state).getProjectSelected(),
        ),
      );
    }
  }

  TextFieldNonBorder _buildTextNameTask(TaskAddState state) {
    _textNameTaskController
      ..text = state.taskAdd.name ?? ''
      ..selection =
          TextSelection.collapsed(offset: state.taskAdd.name?.length ?? 0);

    return TextFieldNonBorder(
      hint: 'Ví dụ: Đọc sách',
      controller: _textNameTaskController,
      onChanged: (value) {
        _taskAdd.add(TaskAddChanged(taskName: value));
      },
    );
  }

  void _intDataUI(HomeState state) {
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
      _taskAdd.add(TaskAddChanged(priority: Task.kPriority1));
    } else if (choice.title.contains("2")) {
      _taskAdd.add(TaskAddChanged(priority: Task.kPriority2));
    } else if (choice.title.contains("3")) {
      _taskAdd.add(TaskAddChanged(priority: Task.kPriority3));
    } else if (choice.title.contains("4")) {
      _taskAdd.add(TaskAddChanged(priority: Task.kPriority4));
    }
  }

  Row buildRowFunction(TaskAddState state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          colorIcon:
              state.taskAdd.labels?.isEmpty ?? true ? kColorBlack2 : Colors.red,
          sizeIcon: 24.0,
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed(
                AppRouter.kSelectLabel,
                arguments: state.taskAdd.labels);
            if (result != null && result is List<Label>) {
              _taskAdd.add(TaskAddChanged(labels: result));
            }
          },
        ),
        PopupMenuButton<DropdownChoice>(
          offset: const Offset(0, -200),
          onSelected: _onDropdownPriorityChanged,
          elevation: 6,
          icon: CircleInkWell(
            dropdownChoicesPriority[state.taskAdd.priority - 1].iconData,
            colorIcon:
                dropdownChoicesPriority[state.taskAdd.priority - 1].color,
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
          colorIcon: isSendButtonEnable(state) ? Colors.red : kColorBlack2,
          onPressed: isSendButtonEnable(state)
              ? () {
                  _taskAdd.add(SubmitAddTask());
                }
              : null,
        ),
      ],
    );
  }

  Row buildRowDateAndProject(TaskAddState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconOutlineButton(
          DateHelper.getDisplayTextDateFromDate(state.taskAdd.taskDate ?? "") ??
              "No Date",
          Icons.calendar_today,
          colorIcon:
              state.taskAdd.taskDate != null ? Colors.green : kColorGray1,
          colorBorder:
              state.taskAdd.taskDate != null ? Colors.green : kColorGray1,
          onPressed: () async {
            await onPressedPickDate(state);
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        PopupMenuButton<Project>(
          offset: const Offset(0, -100),
          onSelected: (Project project) {
            if (project.id == null) {
              _taskAdd.add(
                  TaskAddChanged(project: const Project(id: '', name: '')));
            } else {
              _taskAdd.add(TaskAddChanged(project: project));
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
              (state.taskAdd.project?.name?.isEmpty ?? true)
                  ? "Inbox"
                  : state.taskAdd.project.name,
              state.taskAdd.project?.id?.isEmpty ?? true
                  ? Icons.calendar_today
                  : Icons.circle,
              onPressed: () {},
              colorIcon: state.taskAdd.project?.color?.isEmpty ?? true
                  ? kColorGray1
                  : HexColor(state.taskAdd.project.color),
              colorBorder: state.taskAdd.project?.color?.isEmpty ?? true
                  ? kColorGray1
                  : HexColor(state.taskAdd.project.color),
            ),
          ),
        ),
      ],
    );
  }

  Future onPressedPickDate(TaskAddState state) async {
    final picker = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        lastDate: DateTime(2100),
        selectedTimeOfDay:
            DateHelper.getTimeOfDayFromDateString(state.taskAdd.taskDate));
    if (picker != null) {
      _taskAdd.add(TaskAddChanged(taskDate: picker.toIso8601String()));
    }
  }

  bool isSendButtonEnable(TaskAddState state) {
    return state.taskAdd.name?.isNotEmpty ?? false;
  }
}
