import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/utils/util.dart';

import '../../../bloc/submit_task/bloc.dart';
import '../../../bloc/task/bloc.dart';
import '../../../data/entity/check_item.dart';
import '../../../data/entity/label.dart';
import '../../../data/entity/project.dart';
import '../../../data/entity/task.dart';
import '../../../di/injection.dart';
import '../../../utils/date_helper.dart';
import '../../../utils/my_const/my_const.dart';
import '../../common_widgets/dropdown_choice.dart';
import '../../common_widgets/widget_circle_inkwell.dart';
import '../../common_widgets/widget_icon_outline_button.dart';
import '../../common_widgets/widget_item_popup_menu.dart';
import '../../common_widgets/widget_text_field_non_border.dart';
import '../../custom_ui/date_picker/custom_picker_dialog.dart';
import '../../custom_ui/hex_color.dart';
import '../../router.dart';
import 'item_checklist.dart';

class ScreenDetailTask extends StatelessWidget {
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();
  final TaskBloc _taskBloc = getIt<TaskBloc>();

  ScreenDetailTask(Task task, {String taskId}) {
    if (task != null) {
      _taskSubmitBloc.add(OpenScreenEditTask(task));
    } else if (taskId != null) {
      _taskSubmitBloc.add(OpenScreenEditTaskWithId(taskId));
    }
  }

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  final TextEditingController _nameTaskController = TextEditingController();
  final TextEditingController _checkListNameController =
      TextEditingController();

  void _intData(DisplayListTasks state) {
    dropdownChoicesProject.clear();
    dropdownChoicesProject.add(const Project(name: "Inbox"));
    dropdownChoicesProject.addAll(state.listProject);

    dropdownChoicesLabel.clear();
    dropdownChoicesLabel.add(Label(
        name: "No Label", color: getHexFromColor(Colors.grey)));
    dropdownChoicesLabel.addAll(state.listLabel);
  }

  @override
  Widget build(BuildContext context) {
    _intData(_taskBloc.state as DisplayListTasks);
    return BlocConsumer<TaskSubmitBloc, TaskSubmitState>(
      cubit: _taskSubmitBloc,
      listenWhen: (previous, current) {
        return previous.success != current.success;
      },
      listener: (context, state) {
        if (state.success) {
          _taskBloc.add(DataListTaskChanged());
          _taskSubmitBloc.add(HandledSuccessState());
        }
      },
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(child: CircularProgressIndicator());
        }
        return WillPopScope(
          onWillPop: () async {
            if (_nameTaskController.text.isNotEmpty) {
              _taskSubmitBloc.add(SubmitEditTask(
                  state.taskSubmit.copyWith(name: _nameTaskController.text)));
            } else {
              _taskSubmitBloc.add(SubmitEditTask());
            }
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
                    const SizedBox(
                      height: 16.0,
                    ),
                    _buildRowCheckBoxAndEditText(context, state),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                          child: _buildButtonDate(state, context),
                        ),
                        if (!(state.taskSubmit.labels?.isEmpty ?? true))
                          _buildListLabel(state),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildRowFunction(context, state),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Checklist",
                            style: kFontSemibold,
                          ),
                        ),
                        if (!(state.taskSubmit.checkList?.isEmpty ?? true))
                          ...state.taskSubmit.checkList
                              .map(
                                (e) => ItemCheckList(
                                  checkItem: e,
                                  onItemCheckChange: (value) {
                                    _taskSubmitBloc.add(UpdateItemCheckList(
                                        e.copyWith(isCheck: value)));
                                  },
                                  onItemCheckNameChange: (value) {
                                    if (value.isNotEmpty) {
                                      _taskSubmitBloc.add(UpdateItemCheckList(
                                          e.copyWith(name: value)));
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  onDeleteCheckItem: () {
                                    _taskSubmitBloc.add(DeleteCheckItem(e.id));
                                  },
                                ),
                              )
                              .toList(),
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

  Row _buildEditTextAddCheckList(TaskSubmitState state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.add,
          sizeIcon: 24.0,
          colorIcon: kColorPrimary,
          onPressed: () {
            if (_checkListNameController.text.isNotEmpty) {
              final checkList = state.taskSubmit.checkList ?? [];
              checkList.add(CheckItem(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                name: _checkListNameController.text,
              ));

              _checkListNameController.text = '';
              _taskSubmitBloc.add(SubmitEditTask(state.taskSubmit.copyWith(
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

  Row _buildListLabel(TaskSubmitState state) {
    return Row(
      children: [
        ...state.taskSubmit.labels
            .map((e) => Container(
                  margin: const EdgeInsets.only(left: 16.0, top: 8.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: HexColor(e.color),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    e.name,
                    style: kFontRegularBlack2,
                  ),
                ))
            .toList()
      ],
    );
  }

  Widget _buildButtonDate(TaskSubmitState state, BuildContext context) {
    Color colorButton = kColorGray1;
    if (state.taskSubmit.taskDate != null) {
      if (DateHelper.isOverDueString(state.taskSubmit.taskDate)) {
        colorButton = Colors.red;
      } else {
        colorButton = Colors.green;
      }
    }
    return IconOutlineButton(
      DateHelper.getDisplayTextDateFromDate(state.taskSubmit.taskDate ?? "") ??
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
      BuildContext context, TaskSubmitState state) {
    _nameTaskController.text = state.taskSubmit.name;
    return Row(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor:
                kListColorPriority[state.taskSubmit.priorityType - 1],
          ),
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
              value: state.taskSubmit.isCompleted,
              onChanged: (value) {
                _taskSubmitBloc.add(SubmitEditTask(
                    state.taskSubmit.copyWith(isCompleted: value)));
              },
              checkColor: Colors.white,
              activeColor:
                  kListColorPriority[state.taskSubmit.priorityType - 1],
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
                _nameTaskController.text = state.taskSubmit.name;
              } else {
                _taskSubmitBloc.add(
                    SubmitEditTask(state.taskSubmit.copyWith(name: value)));
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
            style: state.taskSubmit.isCompleted
                ? kFontRegularGray1_14
                : kFontRegularBlack2_14,
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
      _taskSubmitBloc.add(TaskSubmitDateChanged(picker.toIso8601String()));
    }
  }

  Row _buildRowInfoProject(TaskSubmitState state) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12.0,
          color: state.taskSubmit.project?.color?.isEmpty ?? true
              ? kColorGray1
              : HexColor(state.taskSubmit.project.color),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          state.taskSubmit.project?.name?.isEmpty ?? true
              ? "Inbox"
              : state.taskSubmit.project.name,
          style: kFontRegular.copyWith(
            fontSize: 12,
            color: kColorGray1,
          ),
        ),
      ],
    );
  }

  Row _buildRowFunction(BuildContext context, TaskSubmitState state) {
    // print(state.)
    return Row(
      children: [
        CircleInkWell(
          Icons.local_offer_outlined,
          colorIcon: state.taskSubmit.labels?.isEmpty ?? true
              ? kColorBlack2
              : Colors.red,
          sizeIcon: 24.0,
          onPressed: () async {
            await Navigator.of(context).pushNamed(AppRouter.kSelectLabel);
            _taskSubmitBloc.add(SubmitEditTask());
          },
        ),
        PopupMenuButton<DropdownChoice>(
          offset: const Offset(0, -300),
          onSelected: (DropdownChoice choice) {
            onDropdownPriorityChanged(choice);
            _taskSubmitBloc.add(SubmitEditTask());
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
}
