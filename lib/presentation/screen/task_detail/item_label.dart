import 'package:flutter/material.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class ItemLabel extends StatelessWidget {
  final Label label;
  final VoidCallback onPressed;
  const ItemLabel(this.label, {this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: getColorDefaultFromValue(label.color),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text(
          label.name,
          style: kFontRegularWhite_14,
        ),
      ),
    );
  }
}
