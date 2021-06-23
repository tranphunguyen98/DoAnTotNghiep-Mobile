import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/presentation/screen/profile/long_indicator.dart';
import 'package:totodo/utils/my_const/my_const.dart';

enum StatisticType {
  kToday,
  kWeek,
  kMonth,
}

class OverviewTasksStatistic extends StatelessWidget {
  final StatisticType statisticType;
  final IndicatorTypeEnum indicatorType;
  final String label;

  const OverviewTasksStatistic(this.statisticType, this.indicatorType)
      : label = statisticType == StatisticType.kToday
            ? 'so với ngày hôm qua'
            : statisticType == StatisticType.kWeek
                ? 'so với tuần trước'
                : 'so với tháng trước';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.loading) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                indicatorType == IndicatorTypeEnum.kPercent
                    ? 'Phần trăm hoàn thành'
                    : 'Số nhiệm vụ hoàn thành',
                style: kFontSemiboldBlack_14,
              ),
              SizedBox(
                height: 8.0,
              ),
              CompareIndicator(
                label: label,
                value: _getCompareValue(state),
                type: indicatorType,
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                indicatorType == IndicatorTypeEnum.kPercent
                    ? '${_getValue(state).toInt()}%'
                    : _getValue(state).toInt().toString(),
                style: kFontSemiboldPrimary_16,
              ),
            ],
          ),
        );
      },
    );
  }

  double _getValue(ProfileState state) {
    final dataStatisticToday = state.dataStatisticToday;
    final dataStatisticThisWeek = state.listDataStatisticThisWeek;
    if (statisticType == StatisticType.kToday &&
        indicatorType == IndicatorTypeEnum.kValue) {
      return dataStatisticToday.completedTask.toDouble();
    }
    if (statisticType == StatisticType.kToday &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      return (dataStatisticToday.allTask > 0
              ? dataStatisticToday.completedTask / dataStatisticToday.allTask
              : 0.0) *
          100;
    }

    if (statisticType == StatisticType.kWeek &&
        indicatorType == IndicatorTypeEnum.kValue) {
      return dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.completedTask);
    }

    if (statisticType == StatisticType.kWeek &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      final double allTask = dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.allTask);
      final double completedTask = dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.completedTask);
      return completedTask / allTask;
    }
    return 0.0;
  }

  double _getCompareValue(ProfileState state) {
    final dataStatisticToday = state.dataStatisticToday;
    final dataStatisticYesterday = state.dataStatisticYesterday;
    final dataStatisticThisWeek = state.listDataStatisticThisWeek;
    final dataStatisticPreviousWeek = state.listDataStatisticPreviousWeek;
    if (statisticType == StatisticType.kToday &&
        indicatorType == IndicatorTypeEnum.kValue) {
      return dataStatisticToday.completedTask.toDouble() -
          dataStatisticYesterday.completedTask.toDouble();
    }

    if (statisticType == StatisticType.kToday &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      final todayPercent = dataStatisticToday.allTask > 0
          ? dataStatisticToday.completedTask / dataStatisticToday.allTask
          : 0.0;
      final yesterdayPercent = dataStatisticYesterday.allTask > 0
          ? dataStatisticYesterday.completedTask /
              dataStatisticYesterday.allTask
          : 0.0;
      return (todayPercent - yesterdayPercent) * 100;
    }

    if (statisticType == StatisticType.kWeek &&
        indicatorType == IndicatorTypeEnum.kValue) {
      final double thisWeekCompletedTask = dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.completedTask);
      final double previousWeekCompletedTask = dataStatisticPreviousWeek.fold(
          0.0, (value, element) => value + element.completedTask);
      return thisWeekCompletedTask - previousWeekCompletedTask;
    }

    if (statisticType == StatisticType.kWeek &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      final double thisWeekAllTask = dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.allTask);
      final double thisWeekCompletedTask = dataStatisticThisWeek.fold(
          0.0, (value, element) => value + element.completedTask);

      final double previousWeekAllTask = dataStatisticPreviousWeek.fold(
          0.0, (value, element) => value + element.allTask);
      final double previousWeekCompletedTask = dataStatisticPreviousWeek.fold(
          0.0, (value, element) => value + element.completedTask);

      return thisWeekCompletedTask / thisWeekAllTask -
          previousWeekCompletedTask / previousWeekAllTask;
    }
    return 0.0;
  }
}
