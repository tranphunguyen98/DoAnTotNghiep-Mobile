import 'package:flutter/material.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/detail_habit/sc_habit_detail.dart';
import 'package:totodo/presentation/screen/habit/item_habit.dart';

class ListHabit extends StatelessWidget {
  final List<Habit> listHabit;
  final String chosenDay;

  ListHabit(this.listHabit, this.chosenDay);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(AppRouter.kDetailHabit, arguments: {
            HabitDetailScreen.kTypeHabit: listHabit[index],
            HabitDetailScreen.kTypeChosenDay: chosenDay,
          });
          getIt<HabitBloc>().add(OpenScreenHabit());
        },
        child: ItemHabit(listHabit[index], chosenDay),
      ),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Divider(
          height: 1.0,
        ),
      ),
      itemCount: listHabit.length,
    );
  }
}
