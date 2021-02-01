import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/home/item_dawer_expanded.dart';

import 'drawer_item_data.dart';

class ListDrawerItemExpanded extends StatelessWidget {
  final drawerItems = [
    DrawerItemData(
        "Dự án", "assets/ic_project_64.png", DrawerItemData.kTypeProject),
    DrawerItemData("Thẻ", "assets/ic_label_64.png", DrawerItemData.kTypeLabel),
    DrawerItemData(
        "Bộ lọc", "assets/ic_filter_64.png", DrawerItemData.kTypeFilter),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...drawerItems.map((e) => ItemDrawerExpanded(e)).toList()],
    );
  }
}
