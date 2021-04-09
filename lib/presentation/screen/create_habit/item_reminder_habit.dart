import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ItemReminderHabit extends StatelessWidget {
  final String text;

  const ItemReminderHabit({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      width: 86.0,
      margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Center(
        child: Text(text, style: kFontRegularWhite_14),
      ),
      decoration: BoxDecoration(
        color: kColorPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }
}
