import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DrawerItemSelected extends StatelessWidget {
  final DrawerItemData data;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isChild;

  const DrawerItemSelected(this.data,
      {this.isSelected = false, this.onPressed, this.isChild = false});

  @override
  Widget build(BuildContext context) {
    return Ink(
        color: isSelected ? Colors.black12 : Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: isChild ? 40.0 : 16.0,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 20.0,
                  width: 20.0, // fixed width and height
                  child: Image.asset(
                    data.icon,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 16.0),
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
