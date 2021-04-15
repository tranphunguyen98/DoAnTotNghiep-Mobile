import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/habit/item_habit.dart';
import 'package:totodo/utils/my_const/map_const.dart';

class ListHabit extends StatelessWidget {
  final List<Habit> listHabit;

  ListHabit(this.listHabit);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouter.kDetailHabit);
        },
        child: ItemHabit(
          image: listHabit[index].icon.iconImage,
          title: listHabit[index].name,
          unit: listHabit[index].typeHabitGoal == EHabitGoal.archiveItAll.index
              ? null
              : '0/${listHabit[index].totalDayAmount}',
          totalDay: 0,
        ),
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Divider(
          height: 1.0,
        ),
      ),
      itemCount: listHabit.length,
    );
  }
}
