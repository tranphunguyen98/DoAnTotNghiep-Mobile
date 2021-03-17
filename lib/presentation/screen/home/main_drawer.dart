import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/task/bloc.dart';
import '../../../bloc/task/task_bloc.dart';
import '../../../di/injection.dart';
import '../../router.dart';
import 'drawer_item_normal.dart';
import 'header_main_drawer.dart';
import 'list_drawer_item_expanded.dart';
import 'list_drawer_item_selected.dart';

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
