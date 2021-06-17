import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/add_task/add_task_bloc.dart';
import 'package:totodo/bloc/add_task/add_task_event.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/widget_bottom_sheet_add_task.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

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
              : () async {
                  if (state.indexNavigationBarSelected ==
                      HomeState.kBottomNavigationTask) {
                    _showBottomSheetAddTask(context);
                  }
                  if (state.indexNavigationBarSelected ==
                      HomeState.kBottomNavigationHabit) {
                    final result = await Navigator.of(context)
                        .pushNamed(AppRouter.kCreatingHabitList);
                    getIt.get<HabitBloc>().add(OpenScreenHabit());
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
        child: getBottomSheetAddTaskFromState(),
      ),
    );
  }

  BottomSheetAddTask getBottomSheetAddTaskFromState() {
    if (_homeBloc.state.isInProject()) {
      log('test1111', 'isInProject');
      return BottomSheetAddTask(
        projectSelected: _homeBloc.state.getProjectSelected(),
      );
    } else if (_homeBloc.state.isInLabel()) {
      log('test1111', 'isInLabel');
      return BottomSheetAddTask(
        labelSelected: _homeBloc.state.getLabelSelected(),
      );
    } else if (_homeBloc.state.isInPriority()) {
      log('test1111', 'isInPriority');
      return BottomSheetAddTask(
        priority: _homeBloc.state.getPrioritySelected(),
      );
    } else if (_homeBloc.state.indexDrawerSelected ==
        HomeState.kDrawerIndexToday) {
      log('test1111', 'today');
      return BottomSheetAddTask(
        dateTime: DateTime.now().toIso8601String(),
      );
    }
    return const BottomSheetAddTask();
  }
}
