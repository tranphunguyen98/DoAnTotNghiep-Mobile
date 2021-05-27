import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/profile/indicator.dart';

class WeekPieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

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
                centerSpaceRadius: 40,
                sections: showingSections()),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Indicator(
                color: Colors.green,
                label: 'Đúng giờ',
                percent: 40,
                percentIncrease: 2,
              ),
              SizedBox(
                height: 2,
              ),
              Indicator(
                color: Colors.red,
                label: 'Trễ giờ',
                percent: 30,
                percentDecrease: 3,
              ),
              SizedBox(
                height: 2,
              ),
              Indicator(
                color: Colors.yellow,
                label: 'Không có thời gian',
                percent: 15,
                percentIncrease: 2,
              ),
              SizedBox(
                height: 2,
              ),
              Indicator(
                color: Colors.blueGrey,
                label: 'Chưa hoàn thành',
                percent: 15,
                percentIncrease: 2,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 40 : 36;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[400],
            value: 40,
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
            value: 30,
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
            value: 15,
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
            value: 15,
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}
