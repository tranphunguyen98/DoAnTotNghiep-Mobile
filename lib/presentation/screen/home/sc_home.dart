import 'dart:async';

import 'package:connectivity/connectivity.dart';
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

  StreamSubscription connectivitySubscription;

  @override
  void didChangeDependencies() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      log("testAsync", event);
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        getIt<HomeBloc>().add(AsyncData());
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // log("BUILD HOME SCREEN");
    return BlocConsumer<HomeBloc, HomeState>(
      cubit: _homeBloc,
      listenWhen: (previous, current) => previous.asyncing != current.asyncing,
      listener: (context, state) {
        if (state.asyncing) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Đang đồng bộ dữ liệu...'),
            duration: Duration(milliseconds: 1000),
          ));
        }
      },
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

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }
}
