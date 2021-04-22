import 'package:flutter/material.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_habit_repository.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/map_const.dart';

class ItemHabit extends StatelessWidget {
  final Habit _habit;

  const ItemHabit(
    this._habit,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              //TODO move to bloc
              getIt<IHabitRepository>().updateHabit('authorization',
                  _habit.copyWith(isFinished: !_habit.isFinished));
              getIt<HabitBloc>().add(OpenScreenHabit());
            },
            child: _habit.isFinished
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
                      '0/${_habit.totalDayAmount}',
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
                0.toString(), // TODO add total day
                style: kFontMediumBlack_14,
              ),
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
