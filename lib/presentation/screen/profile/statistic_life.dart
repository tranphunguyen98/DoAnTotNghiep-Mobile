import 'package:charter/charter.dart';
import 'package:flutter/material.dart';

class StatisticLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 100),
      child: PolarAreaChart.basic(
          grid: [30, 60, 90, 120], // Scale for the whole chart
          features: [
            "Tài Chính",
            "Tình Cảm",
            "Sức Khỏe",
            "Sự nghiệp",
            "Gia Đình",
            "Bản Thân",
            "Bạn Bè",
            "Thú Vui",
          ],
          data: [
            30,
            100,
            50,
            30,
            65,
            50,
            80,
            20,
          ],
          featuresTextStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          drawSegmentDividers: true,
          featureColors: [
            Colors.pinkAccent,
            Colors.red,
            Colors.orange,
            Colors.greenAccent,
            Colors.green,
            Colors.lightBlueAccent,
            Colors.blue,
            Colors.purple
          ]),
    );
  }
}
