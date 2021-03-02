import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class FlatButtonDefault extends StatelessWidget {
  final String text;
  final bool isEnable;
  final void Function() onPressed;

  const FlatButtonDefault({this.isEnable = false, this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        disabledColor: kColorGray1_50,
        onPressed: onPressed,
        color: onPressed != null ? kColorPrimary : kColorGray1_50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text.toUpperCase(),
          style: kFontSemiboldWhite_18,
        ),
      ),
    );
  }
}
