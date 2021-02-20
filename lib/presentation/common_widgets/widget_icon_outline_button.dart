import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class IconOutlineButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color colorIcon;
  final void Function() onPressed;

  const IconOutlineButton(this.title, this.iconPath,
      {@required this.onPressed, this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: kColorGray1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.0,
            width: 16.0, // fixed width and height
            child: Image.asset(
              iconPath,
              color: colorIcon ?? kColorGray1,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            this.title,
            style: TextStyle(
              color: kColorGray1,
            ),
          ),
        ],
      ),
    );
  }
}
