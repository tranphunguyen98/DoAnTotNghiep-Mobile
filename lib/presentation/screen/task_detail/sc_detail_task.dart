import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/bloc/task_detail/bloc.dart';
import 'package:totodo/data/model/check_item.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/task.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/barrel_common_widgets.dart';
import 'package:totodo/presentation/common_widgets/url_image.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_icon_outline_button.dart';
import 'package:totodo/presentation/common_widgets/widget_item_popup_menu.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/presentation/custom_ui/date_picker/custom_picker_dialog.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/dropdown_choice.dart';
import 'package:totodo/presentation/screen/task_detail/item_checklist.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/file_helper.dart';
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
  final List<DropdownChoices> dropdownChoices = [];

  final TextEditingController _nameTaskController = TextEditingController();
  final TextEditingController _descriptionTaskController =
      TextEditingController();
  final TextEditingController _checkListNameController =
      TextEditingController();

  final String _idDebounce = 'debounceDetailTask';
  final picker = ImagePicker();

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
    return BlocConsumer<TaskDetailBloc, TaskDetailState>(
      cubit: _taskDetailBloc,
      listenWhen: (previous, current) =>
          previous.taskEdit.isTrashed != current.taskEdit.isTrashed,
      listener: (context, state) {
        if (state.taskEdit.isTrashed == true) {
          _homeBloc.add(DataListTaskChanged());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state.loading == true) {
          return const Center(child: CircularProgressIndicator());
        }
        return WillPopScope(
          onWillPop: () async {
            _saveNameTask(state);
            //TODO fix save name
            _homeBloc.add(DataListTaskChanged());
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
              actions: [
                PopupMenuButton<DropdownChoices>(
                  onSelected: (DropdownChoices choice) {
                    choice.onPressed(context);
                  },
                  elevation: 6,
                  icon: Icon(
                    Icons.more_vert,
                    color: kColorWhite,
                  ),
                  itemBuilder: (BuildContext context) {
                    return dropdownChoices.map((DropdownChoices choice) {
                      return PopupMenuItem<DropdownChoices>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                )
              ],
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
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildRowFunction(context, state),
                        ),
                        _buildListLabel(state),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildDescription(state),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Divider(),
                        ),
                        _buildCheckList(state),
                        _buildEditTextAddCheckList(state),
                        SizedBox(height: 16),
                        _buildImages(state),
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
    _descriptionTaskController.dispose();
    super.dispose();
  }

  void _saveNameTask(TaskDetailState state) {
    if (_descriptionTaskController.text.isNotEmpty &&
        _descriptionTaskController.text != state.taskEdit.description) {
      _taskDetailBloc.add(SubmitEditTask(state.taskEdit
          .copyWith(description: _descriptionTaskController.text)));
    }
    if (_nameTaskController.text.isNotEmpty &&
        _nameTaskController.text != state.taskEdit.name) {
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

    dropdownChoices.clear();
    dropdownChoices.add(
      DropdownChoices(
        title: 'Xóa Task',
        onPressed: (context) {
          _taskDetailBloc.add(DeleteTask());
        },
      ),
    );
  }

  Row _buildEditTextAddCheckList(TaskDetailState state) {
    return Row(
      children: [
        CircleInkWell(
          Icons.add,
          size: 24.0,
          color: kColorPrimary,
          onPressed: () {
            _addCheckList(state);
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
            onFieldSubmitted: (value) => _addCheckList(state),
          ),
        ),
      ],
    );
  }

  void _addCheckList(TaskDetailState state) {
    if (_checkListNameController.text.isNotEmpty) {
      final checkList = <CheckItem>[];
      checkList.addAll(state.taskEdit.checkList ?? []);
      checkList.add(
        CheckItem(
          id: ObjectId().hexString,
          name: _checkListNameController.text,
        ),
      );
      _checkListNameController.text = '';
      _taskDetailBloc.add(
        SubmitEditTask(
          state.taskEdit.copyWith(
            checkList: checkList,
          ),
        ),
      );
    }
  }

  Widget _buildDescription(TaskDetailState state) {
    _descriptionTaskController.text = state.taskEdit.description;
    return TextFormField(
      controller: _descriptionTaskController,
      minLines: 3,
      maxLines: 3,
      decoration: const InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: 'Mô tả',
      ),
      style: state.taskEdit.isCompleted
          ? kFontRegularGray1_14
          : kFontRegularBlack2_14,
    );
  }

  Widget _buildListLabel(TaskDetailState state) {
    if (!(state.taskEdit.labels?.isEmpty ?? true)) {
      return Wrap(
        children: [
          ...state.taskEdit.labels
              .map((label) => ItemLabel(
                    label,
                    onPressed: () async {
                      final result = await Navigator.of(context).pushNamed(
                          AppRouter.kSelectLabel,
                          arguments: state.taskEdit.labels);
                      if (result != null && result is List<Label>) {
                        _taskDetailBloc.add(SubmitEditTask(
                            state.taskEdit.copyWith(labels: result)));
                      }
                    },
                  ))
              .toList()
        ],
      );
    } else {
      return Row(
        children: [
          Spacer(),
          CircleInkWell(
            Icons.local_offer_outlined,
            color: state.taskEdit.labels?.isEmpty ?? true
                ? kColorBlack2
                : Colors.red,
            size: 24.0,
            onPressed: () async {
              final result = await Navigator.of(context).pushNamed(
                  AppRouter.kSelectLabel,
                  arguments: state.taskEdit.labels);
              if (result != null && result is List<Label>) {
                _taskDetailBloc.add(
                    SubmitEditTask(state.taskEdit.copyWith(labels: result)));
              }
            },
          ),
        ],
      );
    }
  }

  Widget _buildButtonDate(TaskDetailState state, BuildContext context) {
    Color colorButton = kColorGray1;
    if (!(state.taskEdit.dueDate?.isEmpty ?? true)) {
      if (DateHelper.isOverDueString(state.taskEdit.dueDate)) {
        colorButton = Colors.red;
      } else {
        colorButton = Colors.green;
      }
    }
    return IconOutlineButton(
      DateHelper.getDisplayTextDateFromDate(state.taskEdit.dueDate ?? "") ??
          "No Date",
      Icons.calendar_today,
      colorIcon: colorButton,
      colorBorder: colorButton,
      onPressed: () async {
        await onPressedPickDate(context, state);
      },
    );
  }

  Widget _buildButtonRemind(TaskDetailState state, BuildContext context) {
    Color colorButton = kColorGray1;
    if (!(state.taskEdit.crontabSchedule?.isEmpty ?? true)) {
      if (DateHelper.isOverDueString(state.taskEdit.crontabSchedule)) {
        colorButton = Colors.red;
      } else {
        colorButton = Colors.green;
      }
    }
    return IconOutlineButton(
      DateHelper.getDisplayTextDateFromDate(
              state.taskEdit.crontabSchedule ?? "") ??
          "No Date",
      Icons.alarm,
      colorIcon: colorButton,
      colorBorder: colorButton,
      onPressed: () async {
        await onPressedPickRemind(context, state);
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
              value: state.taskEdit.isCompleted ?? false,
              // value: true,
              onChanged: (value) {
                if (value) {
                  _taskDetailBloc.add(SubmitEditTask(state.taskEdit.copyWith(
                      isCompleted: value,
                      completedDate: DateTime.now().toIso8601String())));
                } else {
                  _taskDetailBloc.add(SubmitEditTask(state.taskEdit
                      .copyWith(isCompleted: value, completedDate: "")));
                }
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
    final picker = await showDatePicker(
      context: context,
      initialDate: DateTime.parse((state.taskEdit.dueDate?.isNotEmpty ?? false)
          ? state.taskEdit.dueDate
          : DateTime.now().toIso8601String()),
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
      ),
      lastDate: DateTime(2100),
    );
    if (picker != null) {
      _taskDetailBloc.add(TaskSubmitDateChanged(picker.toIso8601String()));
    }
  }

  Future onPressedPickRemind(
      BuildContext context, TaskDetailState state) async {
    final picker = await showCustomDatePicker(
        context: context,
        initialDate: DateTime.parse(
            (state.taskEdit.crontabSchedule?.isNotEmpty ?? false)
                ? state.taskEdit.crontabSchedule
                : DateTime.now().toIso8601String()),
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        lastDate: DateTime(2100),
        selectedTimeOfDay: DateHelper.getTimeOfDayFromDateString(
            (state.taskEdit.crontabSchedule?.isNotEmpty ?? false)
                ? state.taskEdit.crontabSchedule
                : DateTime.now().toIso8601String()));
    if (picker != null) {
      _taskDetailBloc.add(TaskSubmitRemindChanged(picker.toIso8601String()));
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
        _buildButtonDate(state, context),
        SizedBox(
          width: 16.0,
        ),
        _buildButtonRemind(state, context),
        Spacer(),
        PopupMenuButton<DropdownChoice>(
          offset: const Offset(0, -300),
          onSelected: (DropdownChoice choice) {
            onDropdownPriorityChanged(choice, state);
            _taskDetailBloc.add(SubmitEditTask());
          },
          elevation: 6,
          icon: CircleInkWell(
            dropdownChoicesPriority[state.taskEdit.priority - 1].iconData,
            color: dropdownChoicesPriority[state.taskEdit.priority - 1].color,
            size: 24.0,
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
                        .add(UpdateItemCheckList(e.copyWith(isDone: value)));
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

  Widget _buildImages(TaskDetailState state) {
    return Wrap(
      spacing: 8,
      children: [
        ...state.taskEdit.attachmentInfos?.map((image) {
              if (image.contains(RegExp('($kLocalFolder|jpg|png)'))) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, top: 8.0, right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: image.contains(kLocalFolder)
                            ? Image.file(
                                File(image),
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              )
                            : UrlImage(url: image, height: 120, width: 120),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          _onTap(image, state);
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                );
              }
            })?.toList() ??
            [],
        GestureDetector(
          onTap: () {
            _getImage(state);
          },
          child: Container(
            height: 110,
            width: 110,
            margin: const EdgeInsets.only(bottom: 8.0, top: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(color: Colors.grey[300]),
            ),
            child: Icon(
              Icons.add_photo_alternate,
              size: 32,
              color: Colors.grey[500],
            ),
          ),
        ),
      ],
    );
  }

  void _onTap(String image, TaskDetailState state) {
    final images = state.taskEdit.attachmentInfos;
    images.remove(image);
    _taskDetailBloc.add(
      SubmitEditTask(
        state.taskEdit.copyWith(attachmentInfos: images),
      ),
    );
  }

  Future _getImage(TaskDetailState state) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // setState(() async {
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final List<String> images = [];
      images.addAll(state.taskEdit?.attachmentInfos ?? []);

      final imageFilePath =
          "${ObjectId().hexString}${getExtensionFromPath(imageFile.path)}";
      final newPath = await saveImageFromGallery(
          imageFile.path, state.taskEdit.id, imageFilePath);

      images.add(newPath);
      _taskDetailBloc.add(
        SubmitEditTask(
          state.taskEdit.copyWith(attachmentInfos: images),
        ),
      );
    }
    // });
  }
}
