import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/drawer_item_data.dart';
import 'package:totodo/presentation/screen/home/drawer_item_selected.dart';
import 'package:totodo/utils/util.dart';

class ListDrawerItemSelected extends StatefulWidget {
  @override
  _ListDrawerItemSelectedState createState() => _ListDrawerItemSelectedState();
}

class _ListDrawerItemSelectedState extends State<ListDrawerItemSelected> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      builder: (context, state) {
        return Column(
          children: [
            ...state.drawerItems
                .where((element) => element.type == DrawerItemData.kTypeMain)
                .toList()
                .asMap()
                .entries
                .map(
                  (e) => DrawerItemSelected(
                    e.value,
                    isSelected: e.key == state.indexDrawerSelected,
                    onPressed: () {
                      log("eKey ${e.key} ${state.indexDrawerSelected}");
                      if (e.key != state.indexDrawerSelected) {
                        _homeBloc.add(SelectedDrawerIndexChanged(index: e.key));
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
                .toList()
          ],
        );
      },
    );
  }
}
