import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/add_task/add_task_bloc.dart';
import 'package:totodo/bloc/add_task/add_task_event.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/widget_bottom_sheet_add_task.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class FloatingActionButtonHome extends StatefulWidget {
  @override
  _FloatingActionButtonHomeState createState() =>
      _FloatingActionButtonHomeState();
}

class _FloatingActionButtonHomeState extends State<FloatingActionButtonHome> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      buildWhen: (previous, current) =>
          previous.loading != current.loading ||
          previous.indexNavigationBarSelected !=
              current.indexNavigationBarSelected,
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: state.loading
              ? null
              : () {
                  if (state.indexNavigationBarSelected ==
                      HomeState.kBottomNavigationTask) {
                    _showBottomSheetAddTask(context);
                  }
                  if (state.indexNavigationBarSelected ==
                      HomeState.kBottomNavigationHabit) {
                    Navigator.of(context)
                        .pushNamed(AppRouter.kCreatingHabitList);
                  }
                },
          backgroundColor: kColorPrimary,
          child: Icon(
            Icons.add,
            color: kColorWhite,
          ),
        );
      },
    );
  }

  void _showBottomSheetAddTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
      ),
      context: context,
      builder: (_) => BlocProvider<TaskAddBloc>(
        create: (context) => TaskAddBloc(
          taskRepository: getIt<ITaskRepository>(),
        )..add(OnDataTaskAddChanged()),
        child: _homeBloc.state.isInProject()
            ? BottomSheetAddTask(
                projectSelected: _homeBloc.state.getProjectSelected(),
              )
            : BottomSheetAddTask(),
      ),
    );
  }
}
