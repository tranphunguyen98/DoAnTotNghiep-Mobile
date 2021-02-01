import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_item.dart';
import 'drawer_item_data.dart';

class ListDrawerItemSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<List<DrawerItemData>>(
      builder: (context, drawerItems, child) => Column(
        children: [
          ...drawerItems
              .where((element) => element.type == DrawerItemData.kTypeMain)
              .toList()
              .asMap()
              .entries
              .map(
                (e) => DrawerItem(
                  e.value,
                  e.key,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
