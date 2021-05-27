import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/profile/header_profile.dart';
import 'package:totodo/presentation/screen/profile/statistic_life.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

import 'statistic_task.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(
        taskRepository: getIt<ITaskRepository>(),
        userRepository: getIt<IUserRepository>(),
      )..add(InitDataStatistic()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2.0,
          title: Text(
            'Thống kê hiệu suất',
            style: kFontSemiboldWhite_16,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              HeaderProfile(),
              TabBar(
                indicatorColor: kColorPrimary,
                unselectedLabelColor: kColorGray1,
                labelColor: kColorPrimary,
                tabs: const [
                  Tab(
                    text: 'TASK',
                  ),
                  Tab(
                    text: 'LIFE',
                  ),
                  Tab(
                    text: 'HABIT',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StatisticTask(),
                    StatisticLife(),
                    const Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
