import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ChartDetailHabit extends StatefulWidget {
  final int target;
  final List<StepChartItem> listStepChartItem;

  const ChartDetailHabit({
    @required this.target,
    @required this.listStepChartItem,
  });

  @override
  State<StatefulWidget> createState() => ChartDetailHabitState();
}

class ChartDetailHabitState extends State<ChartDetailHabit> {
  static const double barWidth = 8;
  double maxY;
  double target;

  @override
  void initState() {
    target = widget.target.toDouble();

    maxY = widget.listStepChartItem
        .reduce((value, element) =>
            value.currentAmountStep > element.currentAmountStep
                ? value
                : element)
        .currentAmountStep
        .toDouble();

    if (maxY < target) {
      maxY = target;
    }
    maxY = maxY * 1.5;

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
                  value < 50 ? value % 5 == 0 : value % 10 == 0,
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
            barGroups: widget.listStepChartItem
                .map((e) => _makeBarChartGroupData(
                    e.day, e.currentAmountStep.toDouble()))
                .toList()),
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

class StepChartItem {
  final int day;
  final int currentAmountStep;

  StepChartItem(this.day, this.currentAmountStep);
}
