import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/home_appbar.dart';
import 'package:totodo/presentation/screen/home/home_body.dart';
import 'package:totodo/presentation/screen/home/main_bottom_navigation_bar.dart';
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
          previous.indexNavigationBarSelected !=
          current.indexNavigationBarSelected,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kColorWhite,
          appBar: HomeAppBar(),
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
