import 'package:flutter/material.dart';

import '../../../utils/my_const/my_const.dart';

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
          left: isChild ? 38.0 : 16.0,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              size: isChild ? 20 : 24,
            ),
            SizedBox(width: isChild ? 14.0 : 16.0),
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
