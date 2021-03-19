import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';

import '../../../bloc/project/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/my_const.dart';
import '../../../utils/util.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final List<ChooseColor> listColor = [
    ChooseColor(Colors.grey, "Grey"),
    ChooseColor(Colors.red, "Red"),
    ChooseColor(Colors.orange, "Orange"),
    ChooseColor(Colors.yellow, "Yellow"),
    ChooseColor(Colors.green, "Green"),
  ];

  final _projectNameController = TextEditingController();
  ChooseColor dropdownValue;

  final AddProjectBloc _addProjectBloc =
      AddProjectBloc(taskRepository: getIt<ITaskRepository>());

  @override
  void initState() {
    dropdownValue = listColor.first;
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
        ..add(AddedProjectChanged(color: getHexFromColor(dropdownValue.color))),
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
              "Thêm Dự Án",
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
                DropdownButton<ChooseColor>(
                  isExpanded: true,
                  value: dropdownValue,
                  items: listColor.map((value) {
                    return DropdownMenuItem<ChooseColor>(
                        value: value,
                        child: Row(children: [
                          Icon(
                            Icons.circle,
                            size: 16.0,
                            color: value.color,
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Text(value.label),
                        ]));
                  }).toList(),
                  onChanged: (newValue) {
                    _addProjectBloc.add(AddedProjectChanged(
                        color: getHexFromColor(newValue.color)));
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
  final String label;

  ChooseColor(this.color, this.label);
}
