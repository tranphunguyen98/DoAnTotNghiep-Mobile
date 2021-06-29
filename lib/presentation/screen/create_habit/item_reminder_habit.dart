import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totodo/data/model/habit/habit_remind.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ItemReminderHabit extends StatelessWidget {
  final HabitRemind habitRemind;
  final Function(HabitRemind habitRemind) onTap;

  const ItemReminderHabit({@required this.habitRemind, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 36.0,
          width: 82.0,
          margin: EdgeInsets.only(top: 8.0, right: 12.0, bottom: 8.0),
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: kColorPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Center(
            child: Text(
                DateFormat("HH:mm").format(
                    DateTime(0, 0, 0, habitRemind.hour, habitRemind.minute)),
                style: kFontRegularWhite_14),
          ),
        ),
        Positioned(
          right: 4.0,
          top: 0.0,
          child: GestureDetector(
            onTap: () => onTap(habitRemind),
            child: Icon(
              Icons.cancel,
              size: 16.0,
              color: Colors.redAccent,
            ),
          ),
        )
      ],
    );
  }
}
