import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/habit/habit_bloc.dart';
import 'package:totodo/bloc/habit/habit_event.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/habit/list_habit.dart';
import 'package:totodo/presentation/screen/task/widget_empty_data.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ListHabitScreen extends StatefulWidget {
  @override
  _ListHabitScreenState createState() => _ListHabitScreenState();
}

class _ListHabitScreenState extends State<ListHabitScreen> {
  HabitBloc _habitBloc;

  @override
  void initState() {
    _habitBloc = getIt.get<HabitBloc>()
      ..add(ChosenDayChanged(chosenDay: DateTime.now().toIso8601String()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      cubit: _habitBloc,
      builder: (context, state) {
        return
           DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  'Habit',
                  style: kFontSemiboldBlack_16,
                ),
                backgroundColor: kColorWhite,
                bottom: TabBar(
                  indicatorColor: kColorPrimary,
                  tabs: [
                    Tab(
                        icon: Text(
                      'Chưa hoàn thành',
                      style: kFontSemiboldBlack_16,
                    )),
                    Tab(
                        icon: Text(
                      'Đã hoàn thành',
                      style: kFontSemiboldBlack_16,
                    )),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  if (state.listActiveHabit.isNotEmpty)
                    ListHabit(state.listActiveHabit, state.chosenDay)
                  else
                    const EmptyData("Chưa có thói quen đang thực hiện"),
                  if (state.listArchivedHabit.isNotEmpty)
                    ListHabit(state.listArchivedHabit, state.chosenDay)
                  else
                    const EmptyData("Chưa có thói quen đã hoàn thành"),
                ],
              ),
            ),
          );
      },
    );
  }
}
