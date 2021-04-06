import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/create_habit/creating_habit_list.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class CreatingHabitList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 12,
      itemBuilder: (context, index) {
        return ItemCreatingHabit(
          imageUrl: index % 2 == 0 ? kIconMeditation : kIconPushUp,
          title: 'Thiền',
          quote: 'Quiet your mind and let the soul speak',
        );
      },
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Divider(
          height: 1.0,
        ),
      ),
    );
  }
}
