import 'package:flutter/material.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class ItemLabel extends StatelessWidget {
  final Label label;
  const ItemLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, top: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: getColorDefaultFromValue(label.color),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        label.name,
        style: kFontRegularWhite_14,
      ),
    );
  }
}
