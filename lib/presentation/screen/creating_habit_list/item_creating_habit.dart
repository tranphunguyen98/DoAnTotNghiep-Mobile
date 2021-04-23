import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemCreatingHabit extends StatelessWidget {
  final Habit habit;
  final VoidCallback onCreatingHabitItemClick;

  const ItemCreatingHabit(this.habit, {this.onCreatingHabitItemClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCreatingHabitItemClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Image.asset(
              habit.icon.iconImage,
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.name,
                  style: kFontRegular,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  habit.motivation.text,
                  style: kFontRegularBlack2_12,
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.add,
              size: 28,
              color: kColorBlack_30,
            )
          ],
        ),
      ),
    );
  }
}
