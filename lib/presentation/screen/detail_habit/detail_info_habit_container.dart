import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/data/model/habit/habit_progress_item.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/detail_habit/item_diary.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DetailInfoHabitContainer extends StatelessWidget {
  DetailHabitState _state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailHabitBloc, DetailHabitState>(
      builder: (context, state) {
        if (state.habit != null) {
          _state = state;
          return Container(
            color: kColorWhite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildRowInfo(),
                  // _buildDivider(),
                  // _buildCalendar(),
                  // _buildDivider(),
                  // _buildMonthlyCompletionRate(),
                  // if (state.habit.typeHabitGoal ==
                  //     EHabitGoal.reachACertainAmount.index)
                  //   _buildDivider(),
                  // if (state.habit.typeHabitGoal ==
                  //     EHabitGoal.reachACertainAmount.index)
                  //   _buildDailyGoals(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildDiary() {
    final List<HabitProgressItem> listHabitProgressHaveDiary = _state
        .habit.habitProgress
        .where((habitProgressItem) => habitProgressItem.diary?.text != null)
        .toList();
    return ContainerInfo(
      title: 'Nhật ký thói quen',
      child: listHabitProgressHaveDiary.isNotEmpty
          ? Column(
              children: listHabitProgressHaveDiary
                  .map((progressHabitItem) => ItemDiary(
                        text: progressHabitItem.diary.text,
                        date: DateTime.parse(progressHabitItem.day),
                      ))
                  .toList())
          : Center(
              child: Text(
                'Chưa có nhật ký',
                style: kFontRegularGray1_14,
              ),
            ),
    );
  }
}
