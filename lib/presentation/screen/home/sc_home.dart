import 'package:flutter/material.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/home_body.dart';
import 'package:totodo/presentation/screen/home/main_bottom_navigation_bar.dart';
import 'package:totodo/presentation/screen/home/popup_menu_button_more.dart';
import 'package:totodo/utils/util.dart';

import '../../../utils/my_const/color_const.dart';
import 'floating_action_button_home.dart';
import 'main_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log("BULD HOME SCREEN");
    getIt<HomeBloc>().add(OpenHomeScreen());
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        title: const Text('ToToDo'),
        iconTheme: IconThemeData(color: kColorWhite),
        actions: [
          PopupMenuButtonMore(),
        ],
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButtonHome(),
      bottomNavigationBar: MainBottomNavigationBar(),
      body: HomeBody(),
    );
  }
}
