import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/submit_task/bloc.dart';
import '../../../bloc/task/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/color_const.dart';
import '../task/sc_dashboard.dart';
import '../task/widget_bottom_sheet_add_task.dart';
import 'bottom_sheet_add_section.dart';
import 'dropdown_choice.dart';
import 'main_drawer.dart';

class HomeScreen extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>()..add(OpenHomeScreen());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<DropdownChoices> dropdownChoices = [];

  void _intData(DisplayListTasks state) {
    dropdownChoices.clear();
    dropdownChoices.addAll([
      DropdownChoices(
          title: "Chỉnh sửa dự án",
          onPressed: (context) {
            //Navigator.pushNamed(context, MyRouter.SETTING);
          }),
      if (state.checkIsInProject())
        DropdownChoices(
            title: "Thêm Section",
            onPressed: (context) {
              final future = showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0)),
                ),
                context: scaffoldKey.currentContext,
                builder: (_) => BottomSheetAddSection(),
              );
              //Navigator.pushNamed(context, MyRouter.SETTING);
            }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      cubit: _taskBloc,
      buildWhen: (previous, current) {
        if (previous is DisplayListTasks && current is DisplayListTasks) {
          if (previous.indexDrawerSelected != current.indexDrawerSelected) {
            return true;
          }
        }
        return false;
      },
      builder: (context, state) {
        if ((state as DisplayListTasks).drawerItems != null) {
          _intData(state as DisplayListTasks);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text('ToToDo'),
              iconTheme: IconThemeData(color: kColorWhite),
              actions: [
                PopupMenuButton<DropdownChoices>(
                  onSelected: (DropdownChoices choice) {
                    choice.onPressed(context);
                  },
                  elevation: 6,
                  icon: Icon(
                    Icons.more_vert,
                    color: kColorWhite,
                  ),
                  itemBuilder: (BuildContext context) {
                    return dropdownChoices.map((DropdownChoices choice) {
                      return PopupMenuItem<DropdownChoices>(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            drawer: MainDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                getIt<TaskSubmitBloc>().add(OpenBottomSheetAddTask());

                final future = showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0)),
                  ),
                  context: context,
                  builder: (_) => BottomSheetAddTask(),
                );
                // future.then((value) {
                //   getIt<TaskSubmitBloc>().add(OpenBottomSheetAddTask());
                // });
              },
              backgroundColor: kColorPrimary,
              child: Icon(
                Icons.add,
                color: kColorWhite,
              ),
            ),
            body: DashboardScreen(),
          );
        }
        return Container();
      },
    );
  }
}
