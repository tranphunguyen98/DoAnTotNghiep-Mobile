import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:totodo/presentation/screen/create_habit/body_creating_advance_info_habit.dart';
import 'package:totodo/presentation/screen/create_habit/body_creating_basic_info_habit.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class CreateHabitScreen extends StatefulWidget {
  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final int kIndexInfoBasic = 0;
  final int kIndexInfoAdvance = 1;

  int index;

  @override
  void initState() {
    index = kIndexInfoBasic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorWhite,
        elevation: 0.0,
        title: Text(
          'Tạo thói quen',
          style: kFontMediumBlack_18,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: index == kIndexInfoBasic
                ? BodyCreatingBasicInfoHabit()
                : BodyCreatingAdvanceInfoHabit(),
          ),
          Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: kColorWhite,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (index == kIndexInfoBasic) {
                    index = kIndexInfoAdvance;
                  }
                });
              },
              child: Text(
                index == kIndexInfoBasic ? 'Tiếp tục' : 'Lưu',
                style: kFontMediumWhite_12,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('kIndexInfoBasic', kIndexInfoBasic));
  }
}
