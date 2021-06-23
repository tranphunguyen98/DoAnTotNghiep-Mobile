import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/long_indicator.dart';
import 'package:totodo/presentation/screen/profile/static_week.dart';
import 'package:totodo/presentation/screen/profile/statistic_completed_tasks.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class StatisticTask extends StatelessWidget {
  final StatisticType statisticType;
  const StatisticTask(this.statisticType);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kColorBackgroundLight,
        padding: const EdgeInsets.only(
            top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: OverviewTasksStatistic(
                        statisticType, IndicatorTypeEnum.kValue)),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: OverviewTasksStatistic(
                        statisticType, IndicatorTypeEnum.kPercent)),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            CompletionRateDistributionStatistic(statisticType: statisticType),
            // StatisticToday(),
            // Divider(
            //   height: 32,
            //   color: Colors.grey[500],
            // ),
            // StatisticEveryDayOfWeek(),
            // Divider(
            //   color: Colors.grey[500],
            // ),
            // SizedBox(
            //   height: 8.0,
            // ),
          ],
        ),
      ),
    );
  }
}
