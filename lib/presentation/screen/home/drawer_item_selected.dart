import 'package:flutter/material.dart';

import '../../../utils/my_const/my_const.dart';
import 'drawer_item_data.dart';

class DrawerItemSelected extends StatelessWidget {
  final DrawerItemData data;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isChild;
  final Color colorIcon;

  const DrawerItemSelected(this.data,
      {this.isSelected = false,
      this.onPressed,
      this.isChild = false,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Ink(
        color: isSelected ? Colors.black12 : Colors.transparent,
        child: InkWell(
          onTap: isSelected ? () {} : onPressed,
          child: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: isChild ? 40.0 : 16.0,
            ),
            child: Row(
              children: [
                Icon(data.icon,
                    color: data.color ?? colorIcon ?? kColorGray1,
                    size: isChild ? 14 : 24),
                const SizedBox(width: 16.0),
                Text(
                  data.name,
                  style: kFontSemibold,
                ),
              ],
            ),
          ),
        ));
  }
}
