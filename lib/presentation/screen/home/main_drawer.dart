import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/presentation/screen/home/header_main_drawer.dart';
import 'package:totodo/presentation/screen/home/list_drawer_item_selected.dart';

import 'drawer_item_data.dart';
import 'item_drawer_index_selected.dart';
import 'list_drawer_item_expanded_1.dart';

class MainDrawer extends StatelessWidget {
  int _selectedIndex = 0;
  final drawerItems = [
    DrawerItemData("Dashboard", "assets/ic_dashboard_64.png"),
    DrawerItemData("Hôm nay", "assets/ic_today_64.png"),
    DrawerItemData("7 ngày tiếp theo", "assets/ic_week_64.png"),
    DrawerItemData("Tháng này", "assets/ic_month_64.png"),
    DrawerItemData(
        "Project Mẫu", "assets/ic_circle_64.png", DrawerItemData.kTypeProject),
    DrawerItemData(
        "Nhãn Mẫu", "assets/ic_circle_64.png", DrawerItemData.kTypeLabel),
    DrawerItemData(
        "Ưu tiên 1", "assets/ic_circle_64.png", DrawerItemData.kTypeFilter),
    DrawerItemData(
        "Ưu tiên 2", "assets/ic_circle_64.png", DrawerItemData.kTypeFilter),
    DrawerItemData(
        "Ưu tiên 3", "assets/ic_circle_64.png", DrawerItemData.kTypeFilter),
    DrawerItemData(
        "Ưu tiên 4", "assets/ic_circle_64.png", DrawerItemData.kTypeFilter),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<List<DrawerItemData>>(
          create: (context) => drawerItems,
        ),
        ChangeNotifierProvider<IndexSelectedChangeNotifier>(
          create: (context) => IndexSelectedChangeNotifier(),
        )
      ],
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            HeaderMainDrawer(
              user: User.userMock,
            ),
            ListDrawerItemSelected(),
            ListDrawerItemExpanded(),
          ],
        ),
      ),
    );
  }
}
