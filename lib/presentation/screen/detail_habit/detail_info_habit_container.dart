import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/detail_habit/chart_detail_habit.dart';
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
                  _buildRowInfo(),
                  _buildDivider(),
                  _buildCalendar(),
                  _buildDivider(),
                  _buildMonthlyCompletionRate(),
                  if (state.habit.typeHabitGoal ==
                      EHabitGoal.reachACertainAmount.index)
                    _buildDivider(),
                  if (state.habit.typeHabitGoal ==
                      EHabitGoal.reachACertainAmount.index)
                    _buildDailyGoals(),
                  _buildDivider(),
                  _buildDiary(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildRowInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '10',
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Tổng ngày',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '9',
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Streak dài nhất',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '2',
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Streak hiện tại',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.now().toUtc(),
      focusedDay: DateTime.now(),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        height: 1.0,
      ),
    );
  }

  Widget _buildMonthlyCompletionRate() {
    return ContainerInfo(
      title: 'Tỉ lệ hoàn thành trong tháng',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '10%',
                style: kFontMediumBlack_18,
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(4.0),
                  // width: 240,
                  lineHeight: 6.0,
                  alignment: MainAxisAlignment.center,
                  percent: 0.2,
                  backgroundColor: Colors.grey[200],
                  progressColor: kColorPrimary,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Số ngày hoàn thành: 6 ngày',
            style: kFontRegularGray1_12,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Steak dài nhất: 6 ngày',
            style: kFontRegularGray1_12,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Mục tiêu: 6 ngày',
            style: kFontRegularGray1_12,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoals() {
    return ContainerInfo(
      title: 'Mục tiêu hằng ngày (Count)',
      child: Container(
        height: 240.0,
        padding: EdgeInsets.only(top: 8.0),
        child: ChartDetailHabit(),
      ),
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
                  .map((e) => e.diary.text)
                  .map((e) => ItemDiary(e))
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
