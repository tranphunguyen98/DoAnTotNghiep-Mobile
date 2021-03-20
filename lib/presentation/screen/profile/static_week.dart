import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/chart_pie_week.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class StaticWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tỉ lệ hoàn thành trong tuần',
          style: kFontMediumBlack_14,
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '66.67%',
              style: kFontMediumBlack_22,
            ),
            SizedBox(
              width: 32.0,
            ),
            Expanded(
              child: WeekPieChart(),
            ),
          ],
        ),
      ],
    );
  }
}
