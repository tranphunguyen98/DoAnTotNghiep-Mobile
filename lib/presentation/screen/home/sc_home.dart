import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/home_body.dart';
import 'package:totodo/presentation/screen/home/main_bottom_navigation_bar.dart';
import 'package:totodo/presentation/screen/home/popup_menu_button_more.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/util.dart';

import '../../../utils/my_const/color_const.dart';
import 'floating_action_button_home.dart';
import 'main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = getIt<HomeBloc>()..add(OpenHomeScreen());

  @override
  Widget build(BuildContext context) {
    log("BULD HOME SCREEN");

    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      buildWhen: (previous, current) =>
          // previous.indexDrawerSelected != current.indexDrawerSelected ||
          previous.indexNavigationBarSelected !=
          current.indexNavigationBarSelected,
      builder: (context, state) {
        return Scaffold(
          // key: scaffoldKey,
          backgroundColor: kColorWhite,
          appBar: AppBar(
            elevation: 0.0,
            title: state.indexNavigationBarSelected ==
                    HomeState.kBottomNavigationTask
                ? const Text('ToToDo')
                : Text(
                    'Habit',
                    style: kFontRegularGray4_16,
                  ),
            backgroundColor: state.indexNavigationBarSelected ==
                    HomeState.kBottomNavigationTask
                ? kColorPrimary
                : kColorWhite,
            iconTheme: IconThemeData(
                color: state.indexNavigationBarSelected ==
                        HomeState.kBottomNavigationTask
                    ? kColorWhite
                    : kColorGray4),
            actions: [
              if (state.indexNavigationBarSelected ==
                  HomeState.kBottomNavigationTask)
                PopupMenuButtonMore(),
              if (state.indexNavigationBarSelected ==
                  HomeState.kBottomNavigationHabit) ...[
                CircleInkWell(
                  Icons.book,
                  size: 20,
                  color: kColorGray4,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.kListHabit);
                  },
                ),
                CircleInkWell(
                  Icons.filter_list_outlined,
                  size: 20,
                  color: kColorGray4,
                  onPressed: () {},
                ),
              ]
            ],
          ),
          drawer: state.indexNavigationBarSelected ==
                  HomeState.kBottomNavigationTask
              ? MainDrawer()
              : null,
          floatingActionButton: FloatingActionButtonHome(),
          bottomNavigationBar: MainBottomNavigationBar(),
          body: HomeBody(),
        );
      },
    );
  }
}
