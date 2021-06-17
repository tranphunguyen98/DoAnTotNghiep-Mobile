import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';

import '../../../bloc/project/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/my_const.dart';

class AddProjectScreen extends StatefulWidget {
  final Project project;

  const AddProjectScreen({Key key, this.project}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _projectNameController = TextEditingController();
  Map<String, Object> dropdownValue;

  final AddProjectBloc _addProjectBloc =
      AddProjectBloc(taskRepository: getIt<ITaskRepository>());

  @override
  void initState() {
    final project = widget.project;
    if (project == null) {
      dropdownValue = kListColorDefault.first;
      _addProjectBloc.add(AddedProjectChanged(
          color: dropdownValue[keyListColorValue] as String));
    } else {
      dropdownValue = kListColorDefault.firstWhere(
          (element) => element[keyListColorValue] as String == project.color);
      _projectNameController.text = project.name;
      _addProjectBloc.add(InitProject(project));
    }
    super.initState();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProjectBloc, AddProjectState>(
      cubit: _addProjectBloc
        ..add(AddedProjectChanged(
            color: dropdownValue[keyListColorValue] as String)),
      listener: (context, state) {
        if (state is AddProjectState) {
          if (state == AddProjectState.success()) {
            getIt<HomeBloc>().add(DataProjectChanged());
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            title: Text(
              widget.project == null ? "Thêm Dự Án" : "Sửa Dự Án",
              style: kFontSemiboldWhite_18,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: isDataValid(state)
                    ? () {
                        _addProjectBloc.add(AddProjectSubmit());
                      }
                    : null,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _projectNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Name",
                      errorText: state.isProjectNameValid
                          ? null
                          : 'Tên dự án không hợp lệ!'),
                  onChanged: (value) {
                    _addProjectBloc.add(AddedProjectChanged(name: value));
                  },
                ),
                DropdownButton<Map<String, Object>>(
                  isExpanded: true,
                  value: dropdownValue,
                  items: kListColorDefault.map((value) {
                    return DropdownMenuItem<Map<String, Object>>(
                        value: value,
                        child: Row(children: [
                          Icon(
                            Icons.circle,
                            size: 16.0,
                            color: value[keyListColorColor] as Color,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(value[keyListColorLabel] as String),
                        ]));
                  }).toList(),
                  onChanged: (newValue) {
                    _addProjectBloc.add(AddedProjectChanged(
                        color: newValue[keyListColorValue] as String));
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isDataValid(AddProjectState state) {
    return state.isProjectNameValid &&
        !(_projectNameController?.text?.isEmpty ?? true);
  }
}

class ChooseColor {
  final Color color;
  final String project;

  ChooseColor(this.color, this.project);
}
