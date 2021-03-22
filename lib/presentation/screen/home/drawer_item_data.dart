import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class DrawerItemData {
  static const int kTypeMain = 0;
  static const int kTypeProject = 1;
  static const int kTypeLabel = 2;
  static const int kTypeFilter = 3;

  final String name;
  final IconData icon;
  final Color color;
  final int type;
  final dynamic data;
  final Function(BuildContext) onPressed;

  DrawerItemData(
    this.name,
    this.icon, {
    this.color,
    this.type = kTypeMain,
    this.onPressed,
    this.data,
  });

  @override
  String toString() {
    return 'DrawerItemData{name: $name, icon: $icon, type: $type, data: $data}';
  }

  static List<DrawerItemData> listDrawerItemDateInit = [
    DrawerItemData("Dashboard", Icons.inbox, color: Colors.blue),
    DrawerItemData("Hôm nay", Icons.today, color: Colors.green),
    DrawerItemData("7 ngày tiếp theo", Icons.date_range, color: Colors.red),
  ];

  static List<DrawerItemData> listDrawerItemFilterInit = [
    DrawerItemData(
      'Quan trọng 1',
      Icons.flag,
      color: Colors.red,
      type: kTypeFilter,
      data: 1,
    ),
    DrawerItemData(
      'Quan trọng 2',
      Icons.flag,
      color: Colors.orange,
      type: kTypeFilter,
      data: 2,
    ),
    DrawerItemData(
      'Quan trọng 3',
      Icons.flag,
      color: Colors.blue,
      type: kTypeFilter,
      data: 3,
    ),
    DrawerItemData(
      'Quan trọng 4',
      Icons.flag,
      color: kColorGray1,
      type: kTypeFilter,
      data: 4,
    ),
  ];
}
