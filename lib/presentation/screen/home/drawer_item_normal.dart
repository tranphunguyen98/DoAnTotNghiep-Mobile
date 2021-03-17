import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DrawerItemNormal extends StatelessWidget {
  final String name;
  final IconData iconData;
  final VoidCallback onTap;
  final bool isChild;
  const DrawerItemNormal(this.name, this.iconData, this.onTap,
      {this.isChild = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
          left: isChild ? 40.0 : 16.0,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 20,
            ),
            const SizedBox(width: 16.0),
            Text(
              name,
              style: kFontSemibold,
            ),
          ],
        ),
      ),
    );
  }
}
