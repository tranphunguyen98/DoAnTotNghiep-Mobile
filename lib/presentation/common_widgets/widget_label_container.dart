import 'package:flutter/material.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class LabelContainer extends StatelessWidget {
  final Label label;
  final Function(Label label) onDeleteLabel;

  const LabelContainer({Key key, this.label, this.onDeleteLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 64),
          margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: getColorDefaultFromValue(label.color),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Text(
              label.name,
              style: kFontRegularWhite_14,
            ),
          ),
        ),
        Positioned(
          top: 4.0,
          right: 4.0,
          child: CircleInkWell(
            Icons.close,
            sizeIcon: 24.0,
            onPressed: () {
              onDeleteLabel(label);
            },
          ),
        ),
      ],
    );
  }
}
