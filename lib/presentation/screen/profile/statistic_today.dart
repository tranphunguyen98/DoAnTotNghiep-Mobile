import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class StatisticToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) {
        return previous.dataStatisticToday != current.dataStatisticToday;
      },
      builder: (context, state) {
        if (state.loading) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Thống kê task hoàn thành hôm nay',
              style: kFontMediumBlack_14,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.dataStatisticToday.completedTask}/${state.dataStatisticToday.allTask} tasks',
                  style: kFontMediumBlack_22,
                ),
                Spacer(),
                _buildChartToday(state),
                SizedBox(
                  width: 56.0,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildChartToday(ProfileState state) {
    double percent = 0.0;
    if (state.dataStatisticToday.allTask > 0) {
      percent = state.dataStatisticToday.completedTask /
          state.dataStatisticToday.allTask;
    }

    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 7.0,
      animation: true,
      percent: percent,
      center: Text(
        "${percent * 100}%",
        style: kFontMediumDefault.copyWith(fontSize: 18),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: kColorPrimary,
      backgroundColor: Colors.grey[200],
      // arcBackgroundColor: Colors.red,
    );
  }
}
