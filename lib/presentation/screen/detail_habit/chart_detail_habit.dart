import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ChartDetailHabit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChartDetailHabitState();
}

class ChartDetailHabitState extends State<ChartDetailHabit> {
  static const double barWidth = 8;
  static const double maxY = 60;
  static const double target = 30;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: maxY,
          groupsSpace: 20,
          barTouchData: BarTouchData(
            enabled: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) =>
                  TextStyle(color: kColorBlack2, fontSize: 10),
              margin: 10,
              rotateAngle: 0,
              getTitles: (double value) {
                return (value.toInt() + 1).toString();
              },
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) =>
                  TextStyle(color: kColorBlack2, fontSize: 10),
              getTitles: (double value) {
                return '${value.toInt()}';
              },
              interval: 10,
              margin: 8,
              reservedSize: 30,
            ),
          ),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (value) => value % 10 == 0,
            getDrawingHorizontalLine: (value) {
              if (value == target) {
                return FlLine(color: kColorPrimary, strokeWidth: 0.6);
              }
              if (value == 0) {
                return FlLine(color: const Color(0xff363753), strokeWidth: 3);
              }
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 0.6,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: [
            _makeBarChartGroupData(0, 15),
            _makeBarChartGroupData(1, 30),
            _makeBarChartGroupData(2, 45),
            _makeBarChartGroupData(3, 50),
            _makeBarChartGroupData(4, 50),
            _makeBarChartGroupData(5, 30),
            _makeBarChartGroupData(6, 10),
            _makeBarChartGroupData(7, 45),
            _makeBarChartGroupData(8, 50),
            _makeBarChartGroupData(9, 50),
            _makeBarChartGroupData(10, 30),
            _makeBarChartGroupData(11, 10),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeBarChartGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          width: barWidth,
          colors: [kColorPrimary],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
      ],
    );
  }
}
