import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DrawerItemNormal extends StatelessWidget {
  final String name;
  final IconData iconData;
  final VoidCallback onTap;
  const DrawerItemNormal(this.name, this.iconData, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 20,
            ),
            SizedBox(width: 16.0),
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
