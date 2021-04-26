import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';

import '../../router.dart';
import 'drawer_item_normal.dart';
import 'header_main_drawer.dart';
import 'list_drawer_item_expanded.dart';
import 'list_drawer_item_selected.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: getIt<HomeBloc>(),
      buildWhen: (previous, current) {
        return previous.loading != current.loading;
      },
      builder: (context, state) {
        if (state is HomeState) {
          if (state.loading) {
            return const Drawer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.msg != null) {
            return Center(
              child: Text(state.msg),
            );
          }

          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                HeaderMainDrawer(),
                ListDrawerItemSelected(),
                ListDrawerItemExpanded(),
                DrawerItemNormal("Cài Đặt", Icons.settings, () {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushNamed(AppRouter.kSetting);
                  });
                })
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
