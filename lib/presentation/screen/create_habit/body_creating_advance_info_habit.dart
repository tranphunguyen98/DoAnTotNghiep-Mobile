import 'package:flutter/material.dart';
import 'package:totodo/presentation/custom_ui/custom_check_box.dart';
import 'package:totodo/presentation/custom_ui/custom_radio.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/create_habit/dialog_goal.dart';
import 'package:totodo/presentation/screen/create_habit/item_reminder_habit.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class BodyCreatingAdvanceInfoHabit extends StatefulWidget {
  @override
  _BodyCreatingAdvanceInfoHabitState createState() =>
      _BodyCreatingAdvanceInfoHabitState();
}

class _BodyCreatingAdvanceInfoHabitState
    extends State<BodyCreatingAdvanceInfoHabit> {
  String dropdownValue = kListCategory.first;
  String typeOfFrequency = kListFrequencyType.first;
  int everyNumberOfDay = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFrequency(),
          if (typeOfFrequency == kListFrequencyType.first)
            _buildDailyFrequency(),
          if (typeOfFrequency == kListFrequencyType[1]) _buildWeeklyFrequency(),
          if (typeOfFrequency == kListFrequencyType[2])
            _buildIntervalFrequency(),
          _buildGoal(),
          _buildReminder(),
        ],
      ),
    );
  }

  Widget _buildFrequency() {
    return ContainerInfo(
      title: 'Tần suất thói quen',
      child: GroupRadioButton<String>(
        data: kListFrequencyType.map((e) => RadioModel<String>(e, e)).toList(),
        onRadioValueChanged: (String value) {
          setState(() {
            typeOfFrequency = value;
          });
        },
      ),
    );
  }

  Widget _buildDailyFrequency() {
    return ContainerInfo(
      title: 'Chọn ngày',
      child: GroupCheckBoxButton<String>(
        data: kListDayOfWeek
            .map((e) => CheckBoxModel<String>(text: e, data: e, isCheck: true))
            .toList(),
        onValuesChanged: (List<String> values) {},
      ),
    );
  }

  Widget _buildWeeklyFrequency() {
    return ContainerInfo(
      title: 'Chọn số ngày trong tuần',
      child: GroupRadioButton<int>(
        data: kListWeeklyDays
            .map((e) => RadioModel<int>(e.toString(), e))
            .toList(),
        itemWidth: 56.0,
        onRadioValueChanged: (int value) {},
      ),
    );
  }

  Widget _buildIntervalFrequency() {
    return ContainerInfo(
        title: 'Mỗi $everyNumberOfDay ngày',
        child: Column(
          children: [
            Slider(
              value: everyNumberOfDay.toDouble(),
              min: 2,
              max: 30,
              onChanged: (value) {
                setState(() {
                  everyNumberOfDay = value.toInt();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [Text('2'), Spacer(), Text('30')],
              ),
            )
          ],
        ));
  }

  Widget _buildGoal() {
    return ContainerInfo(
        title: 'Mục tiêu',
        child: SizedBox(
          height: 48,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Hoàn thành trong 1 lân'),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: kColorBlack_30,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return DialogGoal();
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildReminder() {
    return ContainerInfo(
      title: 'Nhắc nhở',
      child: Wrap(
        children: [
          ...['14:30', '15:00', '20:00', '21:00']
              .map((e) => ItemReminderHabit(
                    text: e,
                  ))
              .toList(),
          Container(
            height: 36.0,
            width: 86.0,
            margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Center(
              child: Icon(
                Icons.add,
                size: 24.0,
                color: kColorGray4_40,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(color: kColorGray4_40),
            ),
          )
        ],
      ),
    );
  }
}
