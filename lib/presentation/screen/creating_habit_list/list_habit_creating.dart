import 'package:flutter/material.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/presentation/screen/creating_habit_list/item_creating_habit.dart';

class CreatingHabitList extends StatelessWidget {
  final List<Habit> listHabit;

  const CreatingHabitList({
    @required this.listHabit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: listHabit.length,
      itemBuilder: (context, index) {
        return ItemCreatingHabit(listHabit[index]);
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
