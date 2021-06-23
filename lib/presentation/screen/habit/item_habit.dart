import 'package:flutter/material.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/habit/habit_bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/map_const.dart';

class ItemHabit extends StatelessWidget {
  final Habit _habit;
  final String chosenDay;
  const ItemHabit(
    this._habit,
    this.chosenDay,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              getIt<HabitBloc>().add(ChangeCompletedStateHabit(habit: _habit));
            },
            child: _habit.isDoneOnDay(chosenDay)
                ? SizedBox(
                    width: 48.0,
                    height: 48.0,
                    child: Icon(
                      Icons.check,
                      size: 24,
                      color: kColorGreenLight,
                    ),
                  )
                : Image.asset(
                    _habit.icon.iconImage,
                    width: 48,
                    height: 48,
                  ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _habit.name,
                style: kFontMediumBlack_14,
              ),
              if (_habit.typeHabitGoal == EHabitGoal.reachACertainAmount.index)
                Row(
                  children: [
                    Text(
                      '${_habit.currentAmountOnDay(chosenDay)}/${_habit.totalDayAmount}',
                      style: kFontRegularGray1_12,
                    ),
                  ],
                )
            ],
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _habit.totalDay.toString(),
                style: kFontMediumBlack_14,
              ),
              //TODO error title
              Text(
                'Tổng ngày',
                style: kFontRegularGray1_12,
              )
            ],
          ),
        ],
      ),
    );
  }
}
