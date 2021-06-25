import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_static_day.dart';
import 'package:totodo/presentation/screen/profile/statistic_completed_tasks.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ChartTaskWeek extends StatefulWidget {
  final List<ItemDataStatisticDay> listDataStatisticWeek;
  final StatisticType type;

  const ChartTaskWeek(
    this.listDataStatisticWeek,
    this.type,
  );

  @override
  State<StatefulWidget> createState() => ChartTaskWeekState();
}

class ChartTaskWeekState extends State<ChartTaskWeek> {
  final Color barBackgroundColor = Colors.transparent;
  double maxY;
  // final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    maxY = widget.listDataStatisticWeek
        .reduce((value, element) =>
            value.allTask > element.allTask ? value : element)
        .allTask
        .toDouble();
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                mainBarData(),
                // swapAnimationDuration: animDuration,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 5,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [kColorPrimary],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxY,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    final List<BarChartGroupData> listBarChart = [];
    for (int i = 0; i < widget.listDataStatisticWeek.length; i++) {
      listBarChart.add(makeGroupData(
          i, widget.listDataStatisticWeek[i].completedTask.toDouble(),
          isTouched: i == touchedIndex));
    }
    return listBarChart;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final completedTask =
                  widget.listDataStatisticWeek[group.x.toInt()].completedTask;
              final allTask =
                  widget.listDataStatisticWeek[group.x.toInt()].allTask;

              return BarTooltipItem('$completedTask/$allTask',
                  const TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      maxY: maxY,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
              color: kColorPrimary,
              fontWeight: FontWeight.normal,
              fontSize: 12),
          margin: 16,
          getTitles: (double value) {
            if (widget.type == StatisticType.kWeek) {
              return widget.listDataStatisticWeek[value.toInt()].title;
            } else {
              if (value > 0 && value % 2 == 0) {
                return '${value.toInt()}';
              }
              return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
              TextStyle(color: kColorBlack2, fontSize: 10),
          getTitles: (double value) {
            return '${value.toInt()}';
          },
          interval: maxY < 50
              ? maxY < 10
                  ? 1
                  : 5
              : 10,
          margin: 8,
          reservedSize: 30,
        ),
      ),
      gridData: FlGridData(
        show: true,
        checkToShowHorizontalLine: (value) =>
            value < 10 ? true : value % 2 == 0,
        getDrawingHorizontalLine: (value) {
          if (value == 0) {
            return FlLine(color: const Color(0xff363753), strokeWidth: 3);
          }
          return FlLine(
            color: Colors.grey[400],
            strokeWidth: 0.6,
            dashArray: [3, 3],
          );
        },
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
