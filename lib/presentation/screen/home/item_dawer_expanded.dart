import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/util.dart';

import '../../../bloc/task/bloc.dart';
import '../../../data/entity/label.dart';
import '../../../data/entity/project.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/font_const.dart';
import '../../custom_ui/custom_ui.dart';
import 'drawer_item_data.dart';
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
  bool isFirstTimeOpen = true;

  AnimationController _controller;
  TaskBloc _taskBloc;
  BuildContext _context;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _context = context;
    _taskBloc = getIt<TaskBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColorFromDrawerItem(DrawerItemData drawerItemData) {
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
    log("build expanded");
    return Material(
      child: InkWell(
        onTap: () {
          setState(() {
            _changeExpand();
          });
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(children: [
                Icon(
                  widget.drawerItemData.icon,
                  color: widget.drawerItemData.color ?? kColorBlack2,
                  size: 24,
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
                    onPressed: (value) {
                      setState(() {
                        _changeExpand();
                      });
                    },
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
                    log("listDrawerItem expanded");

                    final listDrawerItem = _getListDrawerItem(state);

                    return Column(
                      children: [
                        ...listDrawerItem,
                        DrawerItemNormal(
                          "Thêm",
                          Icons.add,
                          () {
                            widget.drawerItemData.onPressed(context);
                          },
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

  List<DrawerItemSelected> _getListDrawerItem(DisplayListTasks state) {
    final List<DrawerItemSelected> listDrawerItem = <DrawerItemSelected>[];

    for (int i = 0; i < state.drawerItems.length; i++) {
      if (state.drawerItems[i].type == widget.drawerItemData.type) {
        //expand item when open drawer
        if (isFirstTimeOpen &&
            i == (_taskBloc.state as DisplayListTasks).indexDrawerSelected) {
          isFirstTimeOpen = false;
          _changeExpand();
        }

        final isSelected =
            (i == (_taskBloc.state as DisplayListTasks).indexDrawerSelected) &&
                expandFlag;
        listDrawerItem.add(
          DrawerItemSelected(
            state.drawerItems[i],
            isChild: true,
            colorIcon: _getColorFromDrawerItem(state.drawerItems[i]),
            isSelected: isSelected,
            onPressed: () {
              _taskBloc.add(
                SelectedDrawerIndexChanged(
                  index: i,
                  type: widget.drawerItemData.type,
                ),
              );
              Navigator.of(context).pop();
            },
          ),
        );
      }
    }
    return listDrawerItem;
  }

  void _changeExpand() {
    expandFlag = !expandFlag;
    if (expandFlag) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
