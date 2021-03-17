import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/task/bloc.dart';
import '../../../di/injection.dart';
import 'drawer_item_data.dart';
import 'drawer_item_selected.dart';

class ListDrawerItemSelected extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _taskBloc,
      builder: (context, state) {
        if (state is DisplayListTasks) {
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
                        if (e.key != state.indexDrawerSelected) {
                          _taskBloc
                              .add(SelectedDrawerIndexChanged(index: e.key));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
                  .toList()
            ],
          );
        }
        return Container();
      },
    );
  }
}
