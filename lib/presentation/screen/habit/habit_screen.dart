import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/habit/list_day_last_7_days_radio.dart';
import 'package:totodo/presentation/screen/habit/list_habit.dart';

class HabitScreen extends StatefulWidget {
  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4.0,
        ),
        ListDayLast7DayRadio(
          onRadioValueChanged: (value) {},
        ),
        Expanded(child: ListHabit()),
      ],
    );
  }
}
