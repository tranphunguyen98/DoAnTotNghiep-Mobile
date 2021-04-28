import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/detail_habit/chart_detail_habit.dart';
import 'package:totodo/presentation/screen/detail_habit/item_diary.dart';
import 'package:totodo/utils/date_helper.dart';
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
                  _state.theNumberOfDoneDays.toString(),
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
                  _state.theLongestStreak.toString(),
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
                  _state.theCurrentStreak.toString(),
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
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      availableGestures: AvailableGestures.none,
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          if (_state.habit.isDoneOnDay(day.toIso8601String())) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: kColorGreenLight),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: kColorWhite, fontSize: 14.0),
                ),
              ),
            );
          }
          return null;
        },
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(
                  color:
                      _state.habit.isDoneOnDay(DateTime.now().toIso8601String())
                          ? kColorWhite
                          : kColorPrimary,
                  fontSize: 14.0),
            ),
          );
        },
        rangeHighlightBuilder: (context, day, isWithinRange) {
          final frequency = _state.habit.frequency;

          final weekday =
              DateHelper.convertStandardWeekdayToCustomWeekday(day.weekday);

          final bool isInFrequency = !day.isAfter(DateTime.now()) &&
              (frequency.typeFrequency == EHabitFrequency.weekly.index ||
                  (frequency.typeFrequency == EHabitFrequency.daily.index &&
                      frequency.dailyDays.contains(weekday)));
          if (isInFrequency) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
            );
          }
          return null;
        },
      ),
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
                '${(_state.completedPercentByMonth * 100).toStringAsFixed(2)}%',
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
                  percent: _state.completedPercentByMonth,
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
            'Số ngày hoàn thành: ${_state.theNumberOfDoneDaysInMonth} ngày',
            style: kFontRegularGray1_12,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Steak dài nhất: ${_state.theLongestStreakInMonth} ngày',
            style: kFontRegularGray1_12,
          ),
          //TODO target
          // SizedBox(
          //   height: 8.0,
          // ),
          // Text(
          //   'Mục tiêu: ${_state.theCurrentStreakInMonth} ngày',
          //   style: kFontRegularGray1_12,
          // ),
        ],
      ),
    );
  }

  Widget _buildDailyGoals() {
    List<StepChartItem> listStepChartItem;
    if (DateTime.now().day > 10) {
      listStepChartItem = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
          .map((days) => StepChartItem(
              DateTime.now().subtract(Duration(days: days)).day - 1,
              _state.habit.currentAmountOnDay(DateTime.now()
                  .subtract(Duration(days: days))
                  .toIso8601String())))
          .toList();
    }
    return ContainerInfo(
      title: 'Mục tiêu hằng ngày (Count)',
      child: Container(
        height: 240.0,
        padding: const EdgeInsets.only(top: 8.0),
        child: ChartDetailHabit(
          target: _state.habit.totalDayAmount,
          listStepChartItem: listStepChartItem,
        ),
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
