import 'package:flutter/material.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class LabelContainer extends StatelessWidget {
  final Label label;

  const LabelContainer({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: HexColor(label.color),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Text(
        label.name,
        style: kFontRegularBlack2,
      ),
    );
  }
}
