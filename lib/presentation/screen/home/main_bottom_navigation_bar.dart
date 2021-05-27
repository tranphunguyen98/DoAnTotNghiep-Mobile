import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';

class MainBottomNavigationBar extends StatefulWidget {
  @override
  _MainBottomNavigationBarState createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      buildWhen: (previous, current) =>
          previous.indexNavigationBarSelected !=
          current.indexNavigationBarSelected,
      builder: (context, state) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_rounded), label: 'Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions_rounded), label: 'Habit'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting')
          ],
          onTap: (value) {
            _homeBloc.add(SelectedBottomNavigationIndexChanged(value));
          },
          currentIndex: state.indexNavigationBarSelected,
        );
      },
    );
  }
}
