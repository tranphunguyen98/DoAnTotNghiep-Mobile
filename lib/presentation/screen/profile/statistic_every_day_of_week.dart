import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/presentation/screen/profile/chart_task_week.dart';
import 'package:totodo/presentation/screen/profile/statistic_completed_tasks.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class StatisticEveryDayOfWeek extends StatelessWidget {
  final StatisticType type;

  const StatisticEveryDayOfWeek(
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.loading) return Container();
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type == StatisticType.kWeek
                    ? 'Số nhiệm vụ hoàn thành mỗi ngày trong tuần'
                    : 'Số nhiệm vụ hoàn thành mỗi ngày trong tháng',
                style: kFontMediumBlack_14,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ChartTaskWeek(
                  type == StatisticType.kWeek
                      ? state.listDataStatisticThisWeek
                      : state.listDataStatisticThisMonth,
                  type)
            ],
          ),
        );
      },
    );
  }
}
