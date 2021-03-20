import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/static_week.dart';
import 'package:totodo/presentation/screen/profile/statistic_every_day_of_week.dart';
import 'package:totodo/presentation/screen/profile/statistic_today.dart';

class StatisticTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
        child: Column(
          children: [
            StatisticToday(),
            Divider(
              height: 32,
              color: Colors.grey[500],
            ),
            StatisticEveryDayOfWeek(),
            Divider(
              color: Colors.grey[500],
            ),
            SizedBox(
              height: 8.0,
            ),
            StaticWeek(),
          ],
        ),
      ),
    );
  }
}
