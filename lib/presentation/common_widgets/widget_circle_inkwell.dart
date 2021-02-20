import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class CircleInkWell extends StatelessWidget {
  final double sizeIcon;
  final Color colorIcon;
  final Color colorActiveIcon;
  final IconData iconData;
  final VoidCallback onPressed;

  CircleInkWell(this.iconData,
      {this.colorIcon,
      this.sizeIcon = 32.0,
      this.onPressed,
      this.colorActiveIcon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(
                iconData,
                color: (onPressed != null)
                    ? colorActiveIcon ?? Colors.red
                    : colorIcon ?? kColorBlack2,
                size: sizeIcon,
              )),
        ),
      ),
    );
  }
}
