import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/presentation/screen/profile/chart_pie_week.dart';
import 'package:totodo/presentation/screen/profile/indicator.dart';
import 'package:totodo/presentation/screen/profile/statistic_completed_tasks.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class CompletionRateDistributionStatistic extends StatelessWidget {
  final StatisticType statisticType;

  const CompletionRateDistributionStatistic({Key key, this.statisticType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, state) {
        if (state.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final completionRate = statisticType == StatisticType.kToday
            ? state.completionRateToday
            : statisticType == StatisticType.kWeek
                ? state.completionRateWeek
                : state.completionRateMonth;
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statisticType == StatisticType.kToday
                    ? 'Tỉ lệ hoàn thành trong hôm nay'
                    : statisticType == StatisticType.kWeek
                        ? 'Tỉ lệ hoàn thành tuần này'
                        : 'Tỉ lệ hoàn thành tháng này',
                style: kFontMediumBlack_14,
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Colors.green,
                        label: 'Đúng giờ',
                        value: completionRate.onTime,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Indicator(
                        color: Colors.red,
                        label: 'Trễ giờ',
                        value: completionRate.overdue,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Indicator(
                        color: Colors.yellow,
                        label: 'Không có thời gian',
                        value: completionRate.undated,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Indicator(
                        color: Colors.blueGrey,
                        label: 'Chưa hoàn thành',
                        value: completionRate.uncompleted,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              '${completionRate.completedPercent.toInt()}%',
                              style: kFontMediumBlack_22,
                            ),
                          ),
                        ),
                        WeekPieChart(completionRateData: completionRate),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
