import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/bloc/profile/profile_state.dart';

class WeekPieChart extends StatefulWidget {
  final CompletionRateData completionRateData;

  const WeekPieChart({Key key, this.completionRateData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State(completionRateData);
}

class PieChart2State extends State {
  int touchedIndex;
  final CompletionRateData completionRateData;

  PieChart2State(this.completionRateData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 48,
                sections: showingSections()),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 26 : 18;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[400],
            value: completionRateData.getPercent(completionRateData.onTime),
            title: '40%',
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red[400],
            value: completionRateData.getPercent(completionRateData.overdue),
            title: '30%',
            showTitle: false,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.yellow[400],
            value: completionRateData.getPercent(completionRateData.undated),
            showTitle: false,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.blueGrey[200],
            value:
                completionRateData.getPercent(completionRateData.uncompleted),
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}
