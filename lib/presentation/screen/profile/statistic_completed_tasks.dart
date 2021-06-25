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
    final dataStatisticThisMonth = state.listDataStatisticThisMonth;
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
      final int allTask = dataStatisticThisWeek.fold(
          0, (value, element) => value + element.allTask);
      final int completedTask = dataStatisticThisWeek.fold(
          0, (value, element) => value + element.completedTask);
      if (allTask == 0) {
        return 0.0;
      }
      final result = completedTask.toDouble() / allTask;
      return result * 100;
    }

    if (statisticType == StatisticType.kMonth &&
        indicatorType == IndicatorTypeEnum.kValue) {
      return dataStatisticThisMonth.fold(
          0.0, (value, element) => value + element.completedTask);
    }

    if (statisticType == StatisticType.kMonth &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      final int allTask = dataStatisticThisMonth.fold(
          0, (value, element) => value + element.allTask);
      final int completedTask = dataStatisticThisMonth.fold(
          0, (value, element) => value + element.completedTask);
      if (allTask == 0) {
        return 0.0;
      }
      final result = completedTask.toDouble() / allTask;
      return result * 100;
    }
    return 0.0;
  }

  double _getCompareValue(ProfileState state) {
    final dataStatisticToday = state.dataStatisticToday;
    final dataStatisticYesterday = state.dataStatisticYesterday;
    final dataStatisticThisWeek = state.listDataStatisticThisWeek;
    final dataStatisticPreviousWeek = state.listDataStatisticPreviousWeek;
    final dataStatisticThisMonth = state.listDataStatisticThisMonth;
    final dataStatisticPreviousMonth = state.listDataStatisticPreviousMonth;

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
      final int thisWeekAllTask = dataStatisticThisWeek.fold(
          0, (value, element) => value + element.allTask);
      final int thisWeeCompletedTask = dataStatisticThisWeek.fold(
          0, (value, element) => value + element.completedTask);
      final int previousWeekAllTask = dataStatisticPreviousWeek.fold(
          0, (value, element) => value + element.allTask);
      final int previousWeeCompletedTask = dataStatisticPreviousWeek.fold(
          0, (value, element) => value + element.completedTask);
      final double thisWeekPercent =
          thisWeekAllTask > 0 ? thisWeeCompletedTask / thisWeekAllTask : 0.0;
      final double previousWeekPercent = previousWeekAllTask > 0
          ? previousWeeCompletedTask / previousWeekAllTask
          : 0.0;
      final result = thisWeekPercent - previousWeekPercent;
      return result * 100;
    }

    if (statisticType == StatisticType.kMonth &&
        indicatorType == IndicatorTypeEnum.kValue) {
      final double thisMonthCompletedTask = dataStatisticThisMonth.fold(
          0.0, (value, element) => value + element.completedTask);
      final double previousMonthCompletedTask = dataStatisticPreviousMonth.fold(
          0.0, (value, element) => value + element.completedTask);
      return thisMonthCompletedTask - previousMonthCompletedTask;
    }

    if (statisticType == StatisticType.kMonth &&
        indicatorType == IndicatorTypeEnum.kPercent) {
      final int thisMonthAllTask = dataStatisticThisMonth.fold(
          0, (value, element) => value + element.allTask);
      final int thisWeeCompletedTask = dataStatisticThisMonth.fold(
          0, (value, element) => value + element.completedTask);
      final int previousMonthAllTask = dataStatisticPreviousMonth.fold(
          0, (value, element) => value + element.allTask);
      final int previousMonthCompletedTask = dataStatisticPreviousMonth.fold(
          0, (value, element) => value + element.completedTask);
      final double thisMonthPercent =
          thisMonthAllTask > 0 ? thisWeeCompletedTask / thisMonthAllTask : 0.0;
      final double previousMonthPercent = previousMonthAllTask > 0
          ? previousMonthCompletedTask / previousMonthAllTask
          : 0.0;
      final result = thisMonthPercent - previousMonthPercent;
      return result * 100;
    }

    return 0.0;
  }
}
