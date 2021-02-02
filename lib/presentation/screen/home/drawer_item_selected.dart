import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/presentation/screen/home/item_drawer_index_selected.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DrawerItemSelected extends StatelessWidget {
  final DrawerItemData data;
  final int index;

  const DrawerItemSelected(this.data, this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<IndexSelectedChangeNotifier>(
      builder: (context, indexSelectedModel, child) => Ink(
          color: indexSelectedModel.indexSelected == index
              ? Colors.black12
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              if (index != indexSelectedModel.indexSelected) {
                indexSelectedModel.changeIndexSelected(index);
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 20.0,
                    width: 20.0, // fixed width and height
                    child: Image.asset(
                      data.icon,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    data.name,
                    style: kFontSemibold,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
