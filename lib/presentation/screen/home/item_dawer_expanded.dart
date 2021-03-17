import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/custom_ui/custom_ui.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/utils/my_const/font_const.dart';

import 'drawer_item_normal.dart';
import 'drawer_item_selected.dart';

class ItemDrawerExpanded extends StatefulWidget {
  final DrawerItemData drawerItemData;
  const ItemDrawerExpanded(this.drawerItemData);

  @override
  _ItemDrawerExpandedState createState() => _ItemDrawerExpandedState();
}

class _ItemDrawerExpandedState extends State<ItemDrawerExpanded>
    with SingleTickerProviderStateMixin {
  bool expandFlag = false;
  AnimationController _controller;
  TaskBloc _taskBloc;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _taskBloc = getIt<TaskBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getColorFromDrawerItem(DrawerItemData drawerItemData) {
    if (drawerItemData.type == DrawerItemData.kTypeProject) {
      return HexColor((drawerItemData.data as Project).color);
    }

    if (drawerItemData.type == DrawerItemData.kTypeLabel) {
      return HexColor((drawerItemData.data as Label).color);
    }

    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          setState(
            () {
              expandFlag = !expandFlag;
              if (expandFlag) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          );
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(children: [
                Image.asset(
                  widget.drawerItemData.icon,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  widget.drawerItemData.name,
                  style: kFontSemibold,
                ),
                const Spacer(),
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: ExpandIcon(
                    onPressed: (value) {},
                    isExpanded: expandFlag,
                    color: Colors.black,
                    expandedColor: Colors.black,
                    disabledColor: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.drawerItemData.onPressed(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ]),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: BlocBuilder(
                cubit: _taskBloc,
                builder: (context, state) {
                  if (state is DisplayListTasks) {
                    final List<DrawerItemSelected> listDrawerItem =
                        <DrawerItemSelected>[];
                    for (int i = 0; i < state.drawerItems.length; i++) {
                      if (state.drawerItems[i].type ==
                          widget.drawerItemData.type) {
                        listDrawerItem.add(DrawerItemSelected(
                          state.drawerItems[i],
                          isChild: true,
                          colorIcon:
                              getColorFromDrawerItem(state.drawerItems[i]),
                          onPressed: () {
                            _taskBloc.add(
                              SelectedDrawerIndexChanged(
                                index: i,
                                type: widget.drawerItemData.type,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                        ));
                      }
                    }
                    return Column(
                      children: [
                        ...listDrawerItem,
                        DrawerItemNormal(
                          "Thêm",
                          Icons.add,
                          () {},
                          isChild: true,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
