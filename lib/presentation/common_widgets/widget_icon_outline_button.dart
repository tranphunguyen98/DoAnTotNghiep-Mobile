import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class IconOutlineButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color colorIcon;
  final Color colorBorder;
  final bool isExpanded;
  final void Function() onPressed;

  const IconOutlineButton(this.title, this.iconData,
      {@required this.onPressed,
      this.colorIcon,
      this.colorBorder,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      padding: const EdgeInsets.all(8.0),
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
          Icon(
            iconData,
            size: 12.0,
            color: colorIcon ?? kColorGray1,
          ),
          const SizedBox(
            width: 8.0,
          ),
          if (isExpanded)
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: kColorGray1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (!isExpanded)
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: kColorGray1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
