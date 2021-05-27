import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_keyboard_popup_menu/keep_keyboard_popup_menu.dart';
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
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/presentation/custom_ui/date_picker/custom_picker_dialog.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class BottomSheetAddTask extends StatefulWidget {
  final String sectionId;
  final Project projectSelected;
  final Label labelSelected;
  final String dateTime;
  final int priority;

  const BottomSheetAddTask(
      {this.sectionId,
      this.projectSelected,
      this.labelSelected,
      this.dateTime,
      this.priority});

  @override
  _BottomSheetAddTaskState createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTask> {
  final TextEditingController _textNameTaskController = TextEditingController();

  final List<DropdownChoice> dropdownChoicesPriority =
      DropdownChoice.dropdownChoicesPriority;
  final List<Project> dropdownChoicesProject = [];
  final List<Label> dropdownChoicesLabel = [];

  TaskAddBloc _taskAddBloc;
  bool visible = true;
  TaskAddState addState;

  double get kMenuScreenPadding => 8.0;

  @override
  void initState() {
    _taskAddBloc = BlocProvider.of<TaskAddBloc>(context);
    _initDataTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskAddBloc, TaskAddState>(
      listener: (context, state) {
        if (state.success) {
          getIt<HomeBloc>().add(DataListTaskChanged());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        log("state: $state");
        addState = state;
        _intDataUI();
        return Visibility(
          visible: visible,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextNameTask(),
                  if (!(state.taskAdd.labels?.isEmpty ?? true))
                    _buildListChipLabel(),
                  buildRowDateAndProject(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textNameTaskController.dispose();
    getIt<HomeBloc>().add(DataListTaskChanged());
    super.dispose();
  }

  void _initDataTask() {
    if (widget.projectSelected != null) {
      _taskAddBloc.add(
        TaskAddChanged(
          sectionId: widget.sectionId,
          project: widget.projectSelected,
        ),
      );
    } else if (widget.priority != null) {
      _taskAddBloc.add(
        TaskAddChanged(priority: widget.priority),
      );
    } else if (widget.dateTime != null) {
      log('test1111', 'today1');
      _taskAddBloc.add(
        TaskAddChanged(
          taskDate: widget.dateTime,
        ),
      );
    } else if (widget.labelSelected != null) {
      _taskAddBloc.add(
        TaskAddChanged(labels: [widget.labelSelected]),
      );
    }
  }

  TextFieldNonBorder _buildTextNameTask() {
    return TextFieldNonBorder(
      hint: 'Ví dụ: Đọc sách',
      controller: _textNameTaskController,
      onChanged: (value) {
        _taskAddBloc.add(TaskAddChanged(taskName: value));
      },
    );
  }

  void _intDataUI() {
    dropdownChoicesProject.clear();
    dropdownChoicesProject.add(const Project(name: "Inbox"));
    dropdownChoicesProject.addAll(addState.projects ?? []);

    dropdownChoicesLabel.clear();
    dropdownChoicesLabel.add(Label(
        name: "Thêm Label",
        color: kListColorDefault.first[keyListColorValue] as String));
    dropdownChoicesLabel.addAll(addState.labels ?? []);
  }

  void _onDropdownPriorityChanged(DropdownChoice choice) {
    if (choice.title.contains("1")) {
      _taskAddBloc.add(TaskAddChanged(priority: Task.kPriority1));
    } else if (choice.title.contains("2")) {
      _taskAddBloc.add(TaskAddChanged(priority: Task.kPriority2));
    } else if (choice.title.contains("3")) {
      _taskAddBloc.add(TaskAddChanged(priority: Task.kPriority3));
    } else if (choice.title.contains("4")) {
      _taskAddBloc.add(TaskAddChanged(priority: Task.kPriority4));
    }
  }

  // Row buildRowFunction() {
  //   return Row(
  //     children: [
  //       _buildLabel(),
  //       _buildPriority(),
  //       CircleInkWell(
  //         Icons.alarm,
  //         size: 24.0,
  //         onPressed: () {},
  //       ),
  //       const CircleInkWell(
  //         Icons.mode_comment_outlined,
  //         size: 24.0,
  //       ),
  //       const Spacer(),
  //       CircleInkWell(
  //         Icons.send_outlined,
  //         size: 24.0,
  //         color: isSendButtonEnable() ? Colors.red : kColorBlack2,
  //         onPressed: isSendButtonEnable()
  //             ? () {
  //                 _taskAddBloc.add(SubmitAddTask());
  //                 _textNameTaskController.clear();
  //               }
  //             : null,
  //       ),
  //     ],
  //   );
  // }

  Row buildRowDateAndProject() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLabel(),
        _buildPriority(),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          flex: 8,
          child: IconOutlineButton(
            DateHelper.getDisplayTextDateFromDate(
                    addState.taskAdd.taskDate ?? "") ??
                "No Date",
            Icons.calendar_today,
            colorIcon:
                addState.taskAdd.taskDate != null ? Colors.green : kColorGray1,
            colorBorder:
                addState.taskAdd.taskDate != null ? Colors.green : kColorGray1,
            onPressed: () async {
              await onPressedPickDate();
            },
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(flex:6, child: _buildPopupProject()),
        const SizedBox(
          width: 8.0,
        ),
        CircleInkWell(
          Icons.send_outlined,
          size: 24.0,
          color: isSendButtonEnable() ? Colors.red : kColorBlack2,
          onPressed: isSendButtonEnable()
              ? () {
                  _taskAddBloc.add(SubmitAddTask());
                  _textNameTaskController.clear();
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildPopupProject() {
    return WithKeepKeyboardPopupMenu(
      calculatePopupPosition: (menuSize, overlayRect, buttonRect) {
        if (dropdownChoicesProject.length < 5) {
          return _customCalculatePopupPosition(
              menuSize, overlayRect, buttonRect,
              offsetY: -100);
        }
        return _customCalculatePopupPosition(menuSize, overlayRect, buttonRect,
            offsetY: 8);
      },
      menuItemBuilder: (context, closePopup) => [
        ...dropdownChoicesProject.map((Project project) {
          return KeepKeyboardPopupMenuItem(
              onTap: () async {
                if (project.id == null) {
                  _taskAddBloc.add(
                      TaskAddChanged(project: const Project(id: '', name: '')));
                } else {
                  _taskAddBloc.add(TaskAddChanged(project: project));
                }
                closePopup();
              },
              child: ItemPopupMenu(
                DropdownChoice(
                  title: project.name,
                  color: project.color?.isEmpty ?? true
                      ? kColorGray1
                      : getColorDefaultFromValue(project.color),
                  iconData:
                      project.id?.isEmpty ?? true ? Icons.inbox : Icons.circle,
                ),
              ));
        }).toList(),
      ],
      childBuilder: (context, openPopup) => IconOutlineButton(
        (addState.taskAdd.project?.name?.isEmpty ?? true)
            ? "Inbox"
            : addState.taskAdd.project.name,
        addState.taskAdd.project?.id?.isEmpty ?? true
            ? Icons.calendar_today
            : Icons.circle,
        onPressed: openPopup,
        colorIcon: addState.taskAdd.project?.color?.isEmpty ?? true
            ? kColorGray1
            : getColorDefaultFromValue(addState.taskAdd.project.color),
        colorBorder: addState.taskAdd.project?.color?.isEmpty ?? true
            ? kColorGray1
            : getColorDefaultFromValue(addState.taskAdd.project.color),
      ),
    );
  }

  Future onPressedPickDate() async {
    setState(() {
      visible = false;
    });

    final picker = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.parse(
            addState.taskAdd.taskDate ?? DateTime.now().toIso8601String()),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        lastDate: DateTime(2100),
        selectedTimeOfDay:
            DateHelper.getTimeOfDayFromDateString(addState.taskAdd.taskDate));
    setState(() {
      visible = true;
    });
    if (picker != null) {
      _taskAddBloc.add(TaskAddChanged(taskDate: picker.toIso8601String()));
    }
  }

  bool isSendButtonEnable() {
    return addState.taskAdd.name?.isNotEmpty ?? false;
  }

  Widget _buildLabel() {
    return WithKeepKeyboardPopupMenu(
      calculatePopupPosition: (menuSize, overlayRect, buttonRect) {
        if (dropdownChoicesLabel.length < 5) {
          return _customCalculatePopupPosition(
              menuSize, overlayRect, buttonRect,
              offsetY: -100);
        }
        return _customCalculatePopupPosition(menuSize, overlayRect, buttonRect,
            offsetY: 8);
      },
      menuItemBuilder: (context, closePopup) => [
        ...dropdownChoicesLabel.map((Label label) {
          return KeepKeyboardPopupMenuItem(
            onTap: () async {
              if (label.id == null) {
                closePopup();
                await Navigator.of(context).pushNamed(AppRouter.kAddLabel);
                _taskAddBloc.add(OnDataTaskAddChanged());
              }
              _addLabel(label);
              closePopup();
            },
            child: ItemPopupMenu(
              DropdownChoice(
                title: label.name,
                color: label.color?.isEmpty ?? true
                    ? kColorGray1
                    : getColorDefaultFromValue(label.color),
                iconData:
                    label.id == null ? Icons.add : Icons.local_offer_outlined,
              ),
            ),
          );
        }).toList(),
      ],
      childBuilder: (context, openPopup) => CircleInkWell(
        Icons.local_offer_outlined,
        onPressed: openPopup,
        size: 24.0,
        color: addState.taskAdd.labels?.isEmpty ?? true
            ? kColorBlack2
            : Colors.red,
      ),
    );
  }

  Widget _buildPriority() {
    return WithKeepKeyboardPopupMenu(
      calculatePopupPosition: (menuSize, overlayRect, buttonRect) {
        return _customCalculatePopupPosition(menuSize, overlayRect, buttonRect,
            offsetY: -100);
      },
      menuItemBuilder: (context, closePopup) => [
        ...dropdownChoicesPriority.map((DropdownChoice choice) {
          return KeepKeyboardPopupMenuItem(
              onTap: () async {
                _onDropdownPriorityChanged(choice);
                closePopup();
              },
              child: ItemPopupMenu(choice));
        }).toList(),
      ],
      childBuilder: (context, openPopup) => CircleInkWell(
        dropdownChoicesPriority[addState.taskAdd.priority - 1].iconData,
        color: dropdownChoicesPriority[addState.taskAdd.priority - 1].color,
        size: 24.0,
        onPressed: openPopup,
      ),
    );
  }

  void _addLabel(Label label) {
    //TODO add new event
    final labels = <Label>[];
    labels.addAll(addState.taskAdd.labels ?? []);
    if (!labels.contains(label) && label.id != null) {
      labels.add(label);
    }
    _taskAddBloc.add(TaskAddChanged(labels: labels));
  }

  Offset _customCalculatePopupPosition(
      Size menuSize, Rect overlayRect, Rect buttonRect,
      {double offsetY}) {
    double y = buttonRect.top;

    double x;
    if (buttonRect.left - overlayRect.left >
        overlayRect.right - buttonRect.right) {
      // If button is closer to the right edge, grow to the left.
      x = buttonRect.right - menuSize.width;
    } else {
      x = buttonRect.left;
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < kMenuScreenPadding + overlayRect.left) {
      x = kMenuScreenPadding + overlayRect.left;
    } else if (x + menuSize.width > overlayRect.right - kMenuScreenPadding) {
      x = overlayRect.right - menuSize.width - kMenuScreenPadding;
    }
    if (y < kMenuScreenPadding + overlayRect.top) {
      y = kMenuScreenPadding + overlayRect.top;
    } else if (y + menuSize.height > overlayRect.bottom - kMenuScreenPadding) {
      y = overlayRect.bottom - menuSize.height - kMenuScreenPadding;
    }
    return Offset(x, y + offsetY);
  }

  Widget _buildListChipLabel() {
    return Wrap(
      children: [
        ...addState.taskAdd.labels
            .map(
              (label) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(
                    label.name,
                    style: kFontRegularWhite_14,
                  ),
                  deleteIcon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onDeleted: () {
                    _removeLabel(label);
                  },
                  backgroundColor: getColorDefaultFromValue(label.color),
                ),
              ),
            )
            .toList()
      ],
    );
  }

  void _removeLabel(Label label) {
    final labels = <Label>[];
    labels.addAll(addState.taskAdd.labels ?? []);
    if (labels.contains(label)) {
      labels.remove(label);
    }
    _taskAddBloc.add(TaskAddChanged(labels: labels));
  }
}
