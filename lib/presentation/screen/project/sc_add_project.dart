import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/project/bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/bloc/task/task_event.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/util.dart';

class ChooseColor {
  final Color color;
  final String label;

  ChooseColor(this.color, this.label);
}

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final AddProjectBloc _addProjectBloc = getIt<AddProjectBloc>();
  final List<ChooseColor> listColor = [
    ChooseColor(Colors.grey, "Grey"),
    ChooseColor(Colors.red, "Red"),
    ChooseColor(Colors.orange, "Orange"),
    ChooseColor(Colors.yellow, "Yellow"),
    ChooseColor(Colors.green, "Green"),
  ];

  ChooseColor dropdownValue;

  @override
  void initState() {
    dropdownValue = listColor.first;
    _addProjectBloc.add(OpenAddProjectEvent());
    _addProjectBloc.add(
        AddedProjectChanged(color: Util.getHexFromColor(dropdownValue.color)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: _addProjectBloc,
      listener: (context, state) {
        if (state is AddProjectState) {
          if (state == AddProjectState.success()) {
            print("SUCCESSSS");
            getIt<TaskBloc>().add(DataProjectChanged());
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Thêm Dự Án",
            style: kFontSemiboldWhite_18,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                _addProjectBloc.add(AddProjectSubmit());
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Name"),
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
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(value.label),
                      ]));
                }).toList(),
                onChanged: (newValue) {
                  _addProjectBloc.add(AddedProjectChanged(
                      color: Util.getHexFromColor(newValue.color)));
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
