import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/habit/list_day_last_7_days_radio.dart';
import 'package:totodo/presentation/screen/habit/list_habit.dart';
import 'package:totodo/presentation/screen/task/widget_empty_task.dart';

class HabitScreen extends StatefulWidget {
  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  HabitBloc _habitBloc;

  @override
  void initState() {
    _habitBloc = getIt.get<HabitBloc>()..add(OpenScreenHabit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      cubit: _habitBloc,
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            const SizedBox(
              height: 4.0,
            ),
            ListDayLast7DayRadio(
              onRadioValueChanged: _onChosenDayChanged,
            ),
            Expanded(
              child: state.listHabitWithChosenDay.isNotEmpty
                  ? ListHabit(state.listHabitWithChosenDay, state.chosenDay)
                  : const EmptyTask("Chưa có thói quen"),
            ),
          ],
        );
      },
    );
  }

  void _onChosenDayChanged(DateTime day) {
    _habitBloc.add(ChosenDayChanged(chosenDay: day.toIso8601String()));
  }
}
