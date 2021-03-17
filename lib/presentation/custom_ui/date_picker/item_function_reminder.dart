import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemFunctionReminder extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool isActive;
  final VoidCallback onPressed;
  final VoidCallback onRemoveTime;

  const ItemFunctionReminder({
    @required this.iconData,
    @required this.title,
    @required this.onPressed,
    @required this.onRemoveTime,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: isActive ? kColorPrimary : kColorGray1,
              size: 20.0,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              title,
              style: kFontRegularGray1_14.copyWith(
                color: isActive ? kColorPrimary : kColorGray1,
              ),
            ),
            const Spacer(),
            if (isActive)
              CircleInkWell(
                Icons.close,
                sizeIcon: 20,
                colorIcon: kColorGray1,
                onPressed: onRemoveTime,
              )
          ],
        ),
      ),
    );
  }
}
