import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:totodo/utils/my_const/font_const.dart';

import 'item_data_statistic_project.dart';

class ItemStatisticProject extends StatelessWidget {
  final ItemDataStatisticProject itemData;

  const ItemStatisticProject(this.itemData);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${itemData.nameProject}: ${itemData.totalTask}',
            style: kFontRegularBlack2_14,
          ),
          SizedBox(
            height: 4.0,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.all(4.0),
            width: (width / 2) - 32,
            lineHeight: 6.0,
            percent: itemData.completedTask / itemData.totalTask,
            backgroundColor: Colors.grey[200],
            progressColor: itemData.projectColor,
          ),
        ]);
  }
}
