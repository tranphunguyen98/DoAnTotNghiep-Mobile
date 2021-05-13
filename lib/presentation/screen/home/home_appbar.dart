import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/screen/home/popup_menu_button_more.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../router.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _homeBloc = getIt<HomeBloc>()..add(OpenHomeScreen());
  HomeState _state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.indexNavigationBarSelected !=
            current.indexNavigationBarSelected,
        cubit: _homeBloc,
        builder: (context, state) {
          _state = state;
          return AppBar(
            elevation: 0.0,
            title: getTitle(),
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
                  Icons.menu_book,
                  size: 20,
                  color: kColorGray4,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.kDiary);
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
          );
        });
  }

  Widget getTitle() {
    if (_state.indexNavigationBarSelected == HomeState.kBottomNavigationTask) {
      String title = 'ToDoDo';
      if (_state.indexDrawerSelected == HomeState.kDrawerIndexToday) {
        title = 'Hôm nay';
      }
      return Text(title);
    } else {
      return Text(
        'Habit',
        style: kFontRegularGray4_16,
      );
    }
  }
}
