import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/bloc/label/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ChooseColor {
  final Color color;
  final String label;

  ChooseColor(this.color, this.label);
}

class AddLabelScreen extends StatefulWidget {
  @override
  _AddLabelScreenState createState() => _AddLabelScreenState();
}

class _AddLabelScreenState extends State<AddLabelScreen> {
  final AddLabelBloc _addLabelBloc =
      AddLabelBloc(taskRepository: getIt<ITaskRepository>());

  Map<String, Object> dropdownValue;

  @override
  void initState() {
    dropdownValue = kListColorDefault.first;
    _addLabelBloc.add(
        AddedLabelChanged(color: dropdownValue[keyListColorValue] as String));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      cubit: _addLabelBloc,
      listener: (context, state) {
        if (state is AddLabelState) {
          if (state == AddLabelState.success()) {
            getIt<HomeBloc>().add(DataListLabelChanged());
            Navigator.of(context).pop(state.label);
          }
        }
      },
      buildWhen: (previous, current) {
        if (previous is AddLabelState && current is AddLabelState) {
          return previous.label?.name?.isEmpty !=
                  previous.label?.name?.isEmpty ||
              previous.msg != current.msg;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "Thêm Nhán",
              style: kFontSemiboldWhite_18,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _addLabelBloc.add(AddLabelSubmit());
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
                  decoration: InputDecoration(
                      hintText: "Name",
                      errorText: (state as AddLabelState).msg?.isEmpty ?? true
                          ? null
                          : (state as AddLabelState).msg),
                  onChanged: (value) {
                    _addLabelBloc.add(AddedLabelChanged(name: value));
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
                    _addLabelBloc.add(AddedLabelChanged(
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
}
