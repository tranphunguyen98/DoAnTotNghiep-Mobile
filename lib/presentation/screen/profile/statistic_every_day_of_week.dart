import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/presentation/screen/profile/chart_task_week.dart';
import 'package:totodo/presentation/screen/profile/item_statistic_project.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class StatisticEveryDayOfWeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (!(state.listDataStaticProject?.isEmpty ?? true)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tỉ lệ hoàn thành các ngày trong tuần',
                style: kFontMediumBlack_14,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '66.67%',
                    style: kFontMediumBlack_22,
                  ),
                  const SizedBox(
                    width: 32.0,
                  ),
                  Expanded(child: ChartTaskWeek()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Divider(
                  height: 32.0,
                  color: Colors.grey[300],
                ),
              ),
              _buildRowStatistic(),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Divider(
                  height: 32.0,
                  color: Colors.grey[300],
                ),
              ),
              GridView.builder(
                itemCount: state.listDataStaticProject.length,
                padding: const EdgeInsets.only(right: 16.0),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 32,
                    childAspectRatio: 5),
                itemBuilder: (context, index) {
                  return ItemStatisticProject(
                      state.listDataStaticProject[index]);
                },
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildRowStatistic() {
    return Row(
      children: [
        SizedBox(
          width: 16.0,
        ),
        Column(
          children: [
            Text(
              'Task Đã\nHoàn Thành',
              style: kFontRegularBlack2_14,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              '67',
              style: kFontSemiboldBlack_16,
            )
          ],
        ),
        Spacer(),
        Column(
          children: [
            Text(
              'Task Chưa\nHoàn Thành',
              style: kFontRegularBlack2_14,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              '67',
              style: kFontSemiboldBlack_16,
            )
          ],
        ),
        Spacer(),
        Column(
          children: [
            Text(
              'Thời Gian Đã\nTheo Dõi',
              style: kFontRegularBlack2_14,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              '100 Giờ',
              style: kFontSemiboldBlack_16,
            )
          ],
        ),
        SizedBox(
          width: 32.0,
        )
      ],
    );
  }
}
