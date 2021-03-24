import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/presentation/screen/home/drawer_item_normal.dart';
import 'package:totodo/presentation/screen/home/drawer_item_selected.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

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
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColorFromDrawerItem(DrawerItemData drawerItemData) {
    if (drawerItemData.type == DrawerItemData.kTypeProject) {
      return getColorDefaultFromValue((drawerItemData.data as Project).color);
    }

    if (drawerItemData.type == DrawerItemData.kTypeLabel) {
      return getColorDefaultFromValue((drawerItemData.data as Label).color);
    }

    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
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
              child: BlocBuilder<HomeBloc, HomeState>(
                cubit: _homeBloc,
                builder: (context, state) {
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DrawerItemSelected> _getListDrawerItem(HomeState state) {
    final List<DrawerItemSelected> listDrawerItem = <DrawerItemSelected>[];

    for (int i = 0; i < state.drawerItems.length; i++) {
      if (state.drawerItems[i].type == widget.drawerItemData.type) {
        //expand item when open drawer
        if (isFirstTimeOpen && i == _homeBloc.state.indexDrawerSelected) {
          isFirstTimeOpen = false;
          _changeExpand();
        }

        final isSelected =
            (i == _homeBloc.state.indexDrawerSelected) && expandFlag;
        listDrawerItem.add(
          DrawerItemSelected(
            state.drawerItems[i],
            isChild: true,
            colorIcon: _getColorFromDrawerItem(state.drawerItems[i]),
            isSelected: isSelected,
            onPressed: () {
              _homeBloc.add(
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
