import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:totodo/presentation/screen/profile/indicator.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class StatisticToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tỉ lệ hoàn thành hôm nay',
          style: kFontMediumBlack_14,
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '70%',
              style: kFontMediumBlack_22,
            ),
            Spacer(),
            _buildChartToday(),
            SizedBox(
              width: 56.0,
            ),
          ],
        ),
      ],
    );
  }

  Column _buildChartToday() {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 7.0,
          animation: true,
          percent: 0.7,
          // center:
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "70%",
          //       style: kFontMediumDefault.copyWith(fontSize: 22),
          //     ),
          //     Text(
          //       "Hôm Nay",
          //       style: kFontMediumDefault.copyWith(
          //           fontSize: 12, color: kColorPrimaryLight),
          //     ),
          //   ],
          // ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: kColorPrimary,
          backgroundColor: Colors.grey[200],
          // arcBackgroundColor: Colors.red,
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Indicator(color: kColorPrimary, label: 'Hoàn Thành'),
            SizedBox(
              width: 16.0,
            ),
            Indicator(color: Colors.grey[200], label: 'Chưa Xong'),
          ],
        ),
      ],
    );
  }
}
