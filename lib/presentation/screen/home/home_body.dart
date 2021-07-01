import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/habit/habit_screen.dart';
import 'package:totodo/presentation/screen/setting/setting_body.dart';
import 'package:totodo/presentation/screen/task/sc_task.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      buildWhen: (previous, current) =>
          previous.indexNavigationBarSelected !=
          current.indexNavigationBarSelected,
      builder: (context, state) {
        switch (state.indexNavigationBarSelected) {
          case HomeState.kBottomNavigationTask:
            return TaskScreen();
          case HomeState.kBottomNavigationHabit:
            return HabitScreen();
        }
        return SettingBody();
      },
    );
  }
}
