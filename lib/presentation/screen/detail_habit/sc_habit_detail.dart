import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/detail_habit/detail_info_habit_container.dart';
import 'package:totodo/presentation/screen/detail_habit/header_detail_habit.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class HabitDetailScreen extends StatefulWidget {
  static const kTypeHabit = 'habit';
  static const kTypeChosenDay = 'chosenDay';

  final Habit _habit;
  final String _chosenDay;

  HabitDetailScreen(this._habit, this._chosenDay);

  @override
  _HabitDetailScreenState createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  final _controller = ScrollController();

  double maxHeight;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  @override
  void initState() {
    maxHeight = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailHabitBloc>(
      create: (context) =>
          DetailHabitBloc(habitRepository: getIt<IHabitRepository>())
            ..add(InitDataDetailHabit(
                habit: widget._habit, chosenDay: widget._chosenDay)),
      child: BlocBuilder<DetailHabitBloc, DetailHabitState>(
        builder: (context, state) {
          if (state.habit != null) {
            maxHeight = state.habit.isDoneOnDay(state.chosenDay)
                ? MediaQuery.of(context).size.height - 160
                : MediaQuery.of(context).size.height;
            return Scaffold(
              backgroundColor: kColorWhite,
              body: NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _snapAppbar();
                  return false;
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      stretch: true,
                      flexibleSpace: HeaderDetailHabit(
                        maxHeight: maxHeight,
                        minHeight: minHeight,
                      ),
                      expandedHeight:
                          maxHeight - MediaQuery.of(context).padding.top,
                    ),
                    SliverFillRemaining(child: DetailInfoHabitContainer()),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}
