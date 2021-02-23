import 'package:flutter/material.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/item_dawer_expanded.dart';

import 'drawer_item_data.dart';

class ListDrawerItemExpanded extends StatelessWidget {
  final drawerItemsExpanded = [
    DrawerItemData(
      "Dự án",
      "assets/ic_project_64.png",
      type: DrawerItemData.kTypeProject,
      onPressed: (context) {
        Navigator.of(context).pushNamed(AppRouter.kAddProject);
      },
    ),
    DrawerItemData(
      "Thẻ",
      "assets/ic_filter_64.png",
      type: DrawerItemData.kTypeLabel,
      onPressed: (context) {
        Navigator.of(context).pushNamed(AppRouter.kAddLabel);
      },
    ),
    DrawerItemData("Bộ lọc", "assets/ic_label_64.png",
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
