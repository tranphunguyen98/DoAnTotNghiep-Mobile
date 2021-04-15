import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/habit/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/habit/list_day_last_7_days_radio.dart';
import 'package:totodo/presentation/screen/habit/list_habit.dart';

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
        return Column(
          children: [
            SizedBox(
              height: 4.0,
            ),
            ListDayLast7DayRadio(
              onRadioValueChanged: (value) {},
            ),
            Expanded(child: ListHabit(state.listHabit)),
          ],
        );
      },
    );
  }
}
