import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/label/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/util.dart';

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
  final AddLabelBloc _addLabelBloc = getIt<AddLabelBloc>();
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
    _addLabelBloc.add(OpenAddLabelEvent());
    _addLabelBloc.add(
        AddedLabelChanged(color: Util.getHexFromColor(dropdownValue.color)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      cubit: _addLabelBloc,
      listener: (context, state) {
        print("AddLabelScreen $state}");
        if (state is AddLabelState) {
          if (state == AddLabelState.success()) {
            print("Add Success");
            Navigator.of(context).pop();
          }
        }
      },
      buildWhen: (previous, current) {
        if (previous is AddLabelState && current is AddLabelState) {
          return previous.label?.nameLabel?.isEmpty !=
                  previous.label?.nameLabel?.isEmpty ||
              previous.msg != current.msg;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Thêm Dự Án",
              style: kFontSemiboldWhite_18,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.send),
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
                    _addLabelBloc.add(AddedLabelChanged(nameLabel: value));
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
                    _addLabelBloc.add(AddedLabelChanged(
                        color: Util.getHexFromColor(newValue.color)));
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
