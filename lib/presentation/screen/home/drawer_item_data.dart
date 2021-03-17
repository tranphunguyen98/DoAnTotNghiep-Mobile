import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}
