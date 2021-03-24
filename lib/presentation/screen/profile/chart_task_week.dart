import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/data_ui/item_data_static_day.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ChartTaskWeek extends StatefulWidget {
  final List<ItemDataStatisticDay> listDataStatisticWeek;

  const ChartTaskWeek(
    this.listDataStatisticWeek,
  );

  @override
  State<StatefulWidget> createState() => ChartTaskWeekState();
}

class ChartTaskWeekState extends State<ChartTaskWeek> {
  final Color barBackgroundColor = Colors.grey[200];

  // final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BarChart(
                  mainBarData(),
                  // swapAnimationDuration: animDuration,
                ),
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
    double width = 8,
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
            y: 100,
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
      double percent = 0.0;
      if (widget.listDataStatisticWeek[i].allTask > 0) {
        percent = widget.listDataStatisticWeek[i].completedTask /
            widget.listDataStatisticWeek[i].allTask;
      }
      listBarChart
          .add(makeGroupData(i, percent * 100, isTouched: i == touchedIndex));
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
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
              color: kColorPrimary, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            return widget.listDataStatisticWeek[value.toInt()].title;
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
