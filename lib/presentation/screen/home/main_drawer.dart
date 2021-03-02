import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/bloc/task/task_bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/drawer_item_normal.dart';
import 'package:totodo/presentation/screen/home/header_main_drawer.dart';
import 'package:totodo/presentation/screen/home/list_drawer_item_selected.dart';

import '../../router.dart';
import 'list_drawer_item_expanded_1.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("BUILD MAIN DRAWER");
    return BlocBuilder(
      cubit: getIt<TaskBloc>(),
      buildWhen: (previous, current) {
        return previous is DisplayListTasks &&
            current is DisplayListTasks &&
            previous.loading != current.loading;
      },
      builder: (context, state) {
        if (state is DisplayListTasks) {
          if (state.loading) {
            return Drawer(
              child: const Center(
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
