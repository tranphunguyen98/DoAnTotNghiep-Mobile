import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/util.dart';

class GroupCheckBoxButton<T> extends StatefulWidget {
  final List<CheckBoxModel<T>> data;
  final T defaultSelected;
  final Function(List<T> values) onValuesChanged;

  const GroupCheckBoxButton({
    @required this.data,
    @required this.onValuesChanged,
    this.defaultSelected,
  });

  @override
  GroupCheckBoxButtonState createState() {
    return GroupCheckBoxButtonState<T>();
  }
}

class GroupCheckBoxButtonState<T> extends State<GroupCheckBoxButton<T>> {
  List<CheckBoxModel<T>> _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      ..._data
          .asMap()
          .entries
          .map((e) => GestureDetector(
                onTap: () {
                  log(_data.toString());
                  setState(() {
                    _data[e.key] = e.value.copyWith(isCheck: !e.value.isCheck);
                    log(_data.toString());
                    widget.onValuesChanged(_data
                        .where((element) => element.isCheck)
                        .map((e) => e.data)
                        .toList());
                  });
                },
                child: CheckBoxItem(e.value.text, e.value.isCheck),
              ))
          .toList()
    ]);
  }
}

class CheckBoxItem<T> extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CheckBoxItem(this.text, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: 86.0,
      margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? kColorWhite : kColorGray1, fontSize: 14),
        ),
      ),
      decoration: BoxDecoration(
        color: isSelected ? kColorPrimary : Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }
}

class CheckBoxModel<T> {
  final String text;
  final T data;
  final bool isCheck;

  CheckBoxModel<T> copyWith({
    String text,
    T data,
    bool isCheck,
  }) {
    if ((text == null || identical(text, this.text)) &&
        (data == null || identical(data, this.data)) &&
        (isCheck == null || identical(isCheck, this.isCheck))) {
      return this;
    }

    return CheckBoxModel<T>(
      text: text ?? this.text,
      data: data ?? this.data,
      isCheck: isCheck ?? this.isCheck,
    );
  }

  CheckBoxModel({this.text, this.data, this.isCheck = false});
}
