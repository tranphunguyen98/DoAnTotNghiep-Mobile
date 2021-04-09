import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/util.dart';

class GroupRadioButton<T> extends StatefulWidget {
  final List<RadioModel<T>> data;
  final T defaultSelected;
  final double itemWidth;
  final Function(T value) onRadioValueChanged;

  const GroupRadioButton({
    @required this.data,
    @required this.onRadioValueChanged,
    this.defaultSelected,
    this.itemWidth,
  });

  @override
  GroupRadioButtonState createState() {
    return GroupRadioButtonState<T>();
  }
}

class GroupRadioButtonState<T> extends State<GroupRadioButton<T>> {
  List<RadioModel<T>> _data;
  T itemSelected;

  @override
  void initState() {
    _data = widget.data;
    if (widget.defaultSelected != null) {
      itemSelected = _data
          .firstWhere((element) => element.data == widget.defaultSelected)
          .data;
    } else {
      itemSelected = _data.first.data;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          log("${_data[index].data} : $itemSelected ");
          return GestureDetector(
            onTap: () {
              setState(() {
                itemSelected = _data[index].data;
                widget.onRadioValueChanged(itemSelected);
              });
            },
            child: RadioItem(
              text: _data[index].text,
              isSelected: _data[index].data == itemSelected,
              width: widget.itemWidth,
            ),
          );
        },
      ),
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double width;

  const RadioItem({this.text, this.width, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: width ?? 86.0,
      margin: EdgeInsets.only(right: 8.0),
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

class RadioModel<T> {
  final String text;
  final T data;

  RadioModel(this.text, this.data);
}
