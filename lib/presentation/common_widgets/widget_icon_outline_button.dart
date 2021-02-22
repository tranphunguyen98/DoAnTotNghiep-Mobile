import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class IconOutlineButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color colorIcon;
  final Color colorBorder;
  final void Function() onPressed;

  const IconOutlineButton(this.title, this.iconData,
      {@required this.onPressed, this.colorIcon, this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      borderSide: BorderSide(
        color: colorBorder ?? kColorGray1, //Color of the border
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(
          //   height: 16.0,
          //   width: 16.0, // fixed width and height
          //   child: Image.asset(
          //     iconPath,
          //     color: colorIcon ?? kColorGray1,
          //   ),
          // ),
          Icon(
            iconData,
            size: 16.0,
            color: colorIcon ?? kColorGray1,
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
