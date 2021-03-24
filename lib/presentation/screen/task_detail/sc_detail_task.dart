import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/task_detail/bloc.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/barrel_common_widgets.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/presentation/custom_ui/date_picker/custom_picker_dialog.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/task_detail/item_checklist.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

import 'item_label.dart';

class ScreenDetailTask extends StatefulWidget {
  final Task task;
  final String taskId;

  const ScreenDetailTask(this.task, {this.taskId});

  @override
  _ScreenDetailTaskState createState() => _ScreenDetailTaskState();
}

class _ScreenDetailTaskState extends State<ScreenDetailTask> {
  final TaskDetailBloc _taskDetailBloc =
      TaskDetailBloc(taskRepository: getIt<ITaskRepository>());

  final HomeBloc _homeBloc = getIt<HomeBloc>();

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  final TextEditingController _nameTaskController = TextEditingController();
  final TextEditingController _checkListNameController =
      TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      _taskDetailBloc.add(OpenScreenEditTask(widget.task));
    } else if (widget.taskId != null) {
      _taskDetailBloc.add(OpenScreenEditTaskWithId(widget.taskId));
    }
    _intData(_homeBloc.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      cubit: _taskDetailBloc,
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(child: CircularProgressIndicator());
        }
        return WillPopScope(
          onWillPop: () async {
            _saveNameTask(state);
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              title: Text(
                "Chi tiết Task",
                style: kFontMediumWhite_18,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildRowInfoProject(state),
                    const SizedBox(height: 16.0),
                    _buildRowCheckBoxAndEditText(context, state),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                          child: _buildButtonDate(state, context),
                        ),
                        if (!(state.taskEdit.labels?.isEmpty ?? true))
                          _buildListLabel(state),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildRowFunction(context, state),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Divider(),
                        ),
                        _buildCheckList(state),
                        _buildEditTextAddCheckList(state),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _checkListNameController.dispose();
    _nameTaskController.dispose();
    super.dispose();
  }

  void _saveNameTask(TaskDetailState state) {
    if (_nameTaskController.text.isNotEmpty) {
      _taskDetailBloc.add(SubmitEditTask(
          state.taskEdit.copyWith(name: _nameTaskController.text)));
    }
  }

  void _intData(HomeState state) {
    dropdownChoicesProject.clear();
    dropdownChoicesProject.add(const Project(name: "Inbox"));
    dropdownChoicesProject.addAll(state.listProject);

    dropdownChoicesLabel.clear();
    dropdownChoicesLabel
        .add(Label(name: "No Label", color: getHexFromColor(Colors.grey)));
    dropdownChoicesLabel.addAll(state.listLabel);
  }

  Row _buildEditTextAddCheckList(TaskDetailState state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.add,
          sizeIcon: 24.0,
          colorIcon: kColorPrimary,
          onPressed: () {
            if (_checkListNameController.text.isNotEmpty) {
              final checkList = <CheckItem>[];
              checkList.addAll(state.taskEdit.checkList ?? []);
              checkList.add(CheckItem(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                name: _checkListNameController.text,
              ));

              _checkListNameController.text = '';
              _taskDetailBloc.add(SubmitEditTask(state.taskEdit.copyWith(
                checkList: checkList,
              )));
            }
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFieldNonBorder(
            autoFocus: false,
            hint: 'Thêm Checklist',
            controller: _checkListNameController,
          ),
        )
      ],
    );
  }

  Widget _buildListLabel(TaskDetailState state) {
    return Wrap(
      children: [
        ...state.taskEdit.labels.map((label) => ItemLabel(label)).toList()
      ],
    );
  }

  Widget _buildButtonDate(TaskDetailState state, BuildContext context) {
    Color colorButton = kColorGray1;
    if (state.taskEdit.taskDate != null) {
      if (DateHelper.isOverDueString(state.taskEdit.taskDate)) {
        colorButton = Colors.red;
      } else {
        colorButton = Colors.green;
      }
    }
    return IconOutlineButton(
      DateHelper.getDisplayTextDateFromDate(state.taskEdit.taskDate ?? "") ??
          "No Date",
      Icons.calendar_today,
      colorIcon: colorButton,
      colorBorder: colorButton,
      onPressed: () async {
        await onPressedPickDate(context, state);
      },
    );
  }

  Row _buildRowCheckBoxAndEditText(
      BuildContext context, TaskDetailState state) {
    _nameTaskController.text = state.taskEdit.name;
    return Row(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor:
                kListColorPriority[state.taskEdit.priority - 1],
          ),
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
              value: state.taskEdit.isCompleted,
              onChanged: (value) {
                _taskDetailBloc.add(SubmitEditTask(
                    state.taskEdit.copyWith(isCompleted: value)));
              },
              checkColor: Colors.white,
              activeColor: kListColorPriority[state.taskEdit.priority - 1],
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFormField(
            controller: _nameTaskController,
            onChanged: (value) {},
            onSaved: (value) {},
            onFieldSubmitted: (value) {
              if (value.isEmpty) {
                _nameTaskController.text = state.taskEdit.name;
              } else {
                _taskDetailBloc
                    .add(SubmitEditTask(state.taskEdit.copyWith(name: value)));
                FocusScope.of(context).unfocus();
              }
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Ví Dụ: Đọc sách',
            ),
            style: state.taskEdit.isCompleted
                ? kFontRegularGray1_14
                : kFontRegularBlack2_14,
          ),
        ),
      ],
    );
  }

  Future onPressedPickDate(BuildContext context, TaskDetailState state) async {
    final picker = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.parse(
            state.taskEdit.taskDate ?? DateTime.now().toIso8601String()),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        lastDate: DateTime(2100),
        selectedTimeOfDay:
            DateHelper.getTimeOfDayFromDateString(state.taskEdit.taskDate));
    if (picker != null) {
      _taskDetailBloc.add(TaskSubmitDateChanged(picker.toIso8601String()));
    }
  }

  Row _buildRowInfoProject(TaskDetailState state) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12.0,
          color: state.taskEdit.project?.color?.isEmpty ?? true
              ? kColorGray1
              : getColorDefaultFromValue(state.taskEdit.project.color),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          state.taskEdit.project?.name?.isEmpty ?? true
              ? "Inbox"
              : state.taskEdit.project.name,
          style: kFontRegular.copyWith(
            fontSize: 12,
            color: kColorGray1,
          ),
        ),
      ],
    );
  }

  Row _buildRowFunction(BuildContext context, TaskDetailState state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          colorIcon: state.taskEdit.labels?.isEmpty ?? true
              ? kColorBlack2
              : Colors.red,
          sizeIcon: 24.0,
          onPressed: () async {
            final result = await Navigator.of(context).pushNamed(
                AppRouter.kSelectLabel,
                arguments: state.taskEdit.labels);
            if (result != null && result is List<Label>) {
              _taskDetailBloc
                  .add(SubmitEditTask(state.taskEdit.copyWith(labels: result)));
            }
          },
        ),
        PopupMenuButton<DropdownChoice>(
          offset: const Offset(0, -300),
          onSelected: (DropdownChoice choice) {
            onDropdownPriorityChanged(choice, state);
            _taskDetailBloc.add(SubmitEditTask());
          },
          elevation: 6,
          icon: CircleInkWell(
            dropdownChoicesPriority[state.taskEdit.priority - 1].iconData,
            colorIcon:
                dropdownChoicesPriority[state.taskEdit.priority - 1].color,
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
        const CircleInkWell(Icons.more_vert, sizeIcon: 24.0),
      ],
    );
  }

  Widget _buildCheckList(TaskDetailState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Checklist",
            style: kFontSemibold,
          ),
        ),
        if (!(state.taskEdit.checkList?.isEmpty ?? true))
          ...state.taskEdit.checkList
              .map(
                (e) => ItemCheckList(
                  checkItem: e,
                  onItemCheckChange: (value) {
                    _taskDetailBloc
                        .add(UpdateItemCheckList(e.copyWith(isCheck: value)));
                  },
                  onItemCheckNameChange: (value) {
                    if (value.isNotEmpty) {
                      _taskDetailBloc
                          .add(UpdateItemCheckList(e.copyWith(name: value)));
                      FocusScope.of(context).unfocus();
                    }
                  },
                  onDeleteCheckItem: () {
                    _taskDetailBloc.add(DeleteCheckItem(e.id));
                  },
                ),
              )
              .toList(),
      ],
    );
  }

  void onDropdownPriorityChanged(DropdownChoice choice, TaskDetailState state) {
    if (choice.title.contains("1")) {
      _taskDetailBloc.add(
          SubmitEditTask(state.taskEdit.copyWith(priority: Task.kPriority1)));
    } else if (choice.title.contains("2")) {
      _taskDetailBloc.add(
          SubmitEditTask(state.taskEdit.copyWith(priority: Task.kPriority2)));
    } else if (choice.title.contains("3")) {
      _taskDetailBloc.add(
          SubmitEditTask(state.taskEdit.copyWith(priority: Task.kPriority3)));
    } else if (choice.title.contains("4")) {
      _taskDetailBloc.add(
          SubmitEditTask(state.taskEdit.copyWith(priority: Task.kPriority4)));
    }
  }
}
