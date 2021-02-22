import 'package:flutter/cupertino.dart';

class DrawerItemData {
  static const int kTypeMain = 0;
  static const int kTypeProject = 1;
  static const int kTypeLabel = 2;
  static const int kTypeFilter = 3;

  final String name;
  final String icon;
  final int type;
  final dynamic data;
  final Function(BuildContext) onPressed;
  DrawerItemData(this.name, this.icon,
      {this.type = 0, this.onPressed, this.data});

  @override
  String toString() {
    return 'DrawerItemData{name: $name, icon: $icon, type: $type, data: $data}';
  }

  static List<DrawerItemData> listDrawerItemDateInit = [
    DrawerItemData("Dashboard", "assets/ic_dashboard_64.png"),
    DrawerItemData("Hôm nay", "assets/ic_today_64.png"),
    DrawerItemData("7 ngày tiếp theo", "assets/ic_week_64.png"),
    DrawerItemData("Tháng này", "assets/ic_month_64.png"),
  ];
}
