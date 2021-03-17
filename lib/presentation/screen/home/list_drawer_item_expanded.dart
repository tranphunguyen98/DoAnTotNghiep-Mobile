import 'package:flutter/material.dart';

import '../../router.dart';
import 'drawer_item_data.dart';
import 'item_dawer_expanded.dart';

class ListDrawerItemExpanded extends StatelessWidget {
  final drawerItemsExpanded = [
    DrawerItemData(
      "Dự án",
      Icons.list,
      type: DrawerItemData.kTypeProject,
      onPressed: (context) {
        Navigator.of(context).pushNamed(AppRouter.kAddProject);
      },
    ),
    DrawerItemData(
      "Thẻ",
      Icons.tag,
      type: DrawerItemData.kTypeLabel,
      onPressed: (context) {
        Navigator.of(context).pushNamed(AppRouter.kAddLabel);
      },
    ),
    DrawerItemData("Bộ lọc", Icons.filter_alt_outlined,
        type: DrawerItemData.kTypeFilter),
  ];

  void onAddProject() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...drawerItemsExpanded.map((e) => ItemDrawerExpanded(e)).toList()
      ],
    );
  }
}
