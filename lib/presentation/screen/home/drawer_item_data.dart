import 'package:flutter/cupertino.dart';

class DrawerItemData {
  static const int kTypeMain = 0;
  static const int kTypeProject = 1;
  static const int kTypeLabel = 2;
  static const int kTypeFilter = 3;

  final String name;
  final String icon;
  final int type;
  final Function(BuildContext) onPressed;
  DrawerItemData(this.name, this.icon, {this.type = 0, this.onPressed});
}
