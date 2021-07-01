import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/util.dart';

class GroupEmotionRadioButton extends StatefulWidget {
  final List<int> data;
  final int defaultSelected;
  final double itemWidth;
  final Function(int value) onRadioValueChanged;

  const GroupEmotionRadioButton({
    @required this.data,
    @required this.onRadioValueChanged,
    this.defaultSelected,
    this.itemWidth,
  });

  @override
  GroupEmotionRadioButtonState createState() {
    return GroupEmotionRadioButtonState();
  }
}

class GroupEmotionRadioButtonState<T> extends State<GroupEmotionRadioButton> {
  List<int> _data;
  int itemSelected;

  @override
  void initState() {
    _data = widget.data;
    if (widget.defaultSelected != null) {
      itemSelected =
          _data.firstWhere((element) => element == widget.defaultSelected);
    } else {
      itemSelected = _data.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          // log("${_data[index].data} : $itemSelected ");
          return GestureDetector(
            onTap: () {
              setState(() {
                itemSelected = _data[index];
                widget.onRadioValueChanged(itemSelected);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                _data[index] == itemSelected
                    ? getOnEmotion(_data[index])
                    : getOffEmotion(_data[index]),
                height: 48,
                width: 48,
              ),
            ),
          );
        },
      ),
    );
  }
}
