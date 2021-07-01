import 'dart:io';

import 'package:flutter/material.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/bloc/habit/habit_bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/custom_ui/hex_color.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/map_const.dart';
import 'package:totodo/utils/util.dart';

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
                getIt<HabitBloc>()
                    .add(ChangeCompletedStateHabit(habit: _habit));
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
                  : (_habit.icon.iconImage?.isNotEmpty ?? false)
                      ? _habit.icon.iconImage.length <= 2
                          ? Image.asset(
                              getAssetIcon(int.parse(_habit.icon.iconImage)),
                              width: 48,
                              height: 48,
                            )
                          : Image.file(
                              File(_habit.icon.iconImage),
                              width: 48,
                              height: 48,
                            )
                      : _buildTextIcon(_habit.icon)),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _habit?.name ?? '',
                style: kFontMediumBlack_14,
              ),
              if (_habit.typeHabitGoal == EHabitGoal.reachACertainAmount.index)
                Row(
                  children: [
                    Text(
                      '${_habit.currentAmountOnDay(chosenDay)}/${_habit.missionDayTarget}',
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

  Widget _buildTextIcon(HabitIcon icon) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: HexColor(icon.iconColor),
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Text(
        icon.iconText,
        style: kFontSemiboldWhite_18,
      )),
    );
  }
}
