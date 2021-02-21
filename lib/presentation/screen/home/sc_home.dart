import 'package:flutter/material.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/main_drawer.dart';
import 'package:totodo/presentation/screen/task/sc_dashboard.dart';
import 'package:totodo/presentation/screen/task/widget_bottom_sheet_add_task.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class HomeScreen extends StatelessWidget {
  final TaskBloc _taskBloc = getIt<TaskBloc>()..add(OpenHomeScreen());

  @override
  Widget build(BuildContext context) {
    print("Build Home");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final future = showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0)),
            ),
            context: context,
            builder: (_) => BottomSheetAddTask(),
          );
          future.then((value) {
            // _taskBloc.add(TaskNameChanged(taskName: ""));
          });
        },
        child: Icon(Icons.add),
        backgroundColor: kColorPrimary,
      ),
      body: DashboardScreen(),
    );
  }
}
