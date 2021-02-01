import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/my_const/font_const.dart';

import 'drawer_item.dart';

class ItemDrawerExpanded extends StatefulWidget {
  final DrawerItemData drawerItemData;

  ItemDrawerExpanded(this.drawerItemData);

  @override
  _ItemDrawerExpandedState createState() => _ItemDrawerExpandedState();
}

class _ItemDrawerExpandedState extends State<ItemDrawerExpanded>
    with SingleTickerProviderStateMixin {
  bool expandFlag = false;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(
            () {
              expandFlag = !expandFlag;
              if (expandFlag) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          );
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(children: [
                Image.asset(
                  widget.drawerItemData.icon,
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  widget.drawerItemData.name,
                  style: kFontSemibold,
                ),
                Spacer(),
                ExpandIcon(
                  isExpanded: expandFlag,
                  color: Colors.black,
                  expandedColor: Colors.black,
                  disabledColor: Colors.black,
                ),
                Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ]),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 32.0, top: 8.0, bottom: 8.0, right: 16.0),
                child: Consumer<List<DrawerItemData>>(
                    builder: (context, drawerItems, child) {
                  List<DrawerItem> listDrawerItem = List<DrawerItem>();
                  for (int i = 0; i < drawerItems.length; i++) {
                    if (drawerItems[i].type == widget.drawerItemData.type) {
                      listDrawerItem.add(DrawerItem(drawerItems[i], i));
                    }
                  }
                  return Column(
                    children: [...listDrawerItem],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
