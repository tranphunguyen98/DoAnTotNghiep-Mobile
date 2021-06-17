import 'package:flutter/material.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/map_const.dart';

class DiaryFilterDialog extends StatefulWidget {
  final int dateFilter;
  final Habit habitFilter;
  final List<Habit> habits;

  const DiaryFilterDialog({
    @required this.dateFilter,
    @required this.habitFilter,
    @required this.habits,
  });

  @override
  _DiaryFilterDialogState createState() => _DiaryFilterDialogState();
}

class _DiaryFilterDialogState extends State<DiaryFilterDialog> {
  int dateFilter;
  Habit habitFilter;

  @override
  void initState() {
    dateFilter = widget.dateFilter;
    habitFilter = widget.habitFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Diary Filter',
              style: kFontSemiboldBlack_16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.0),
            Text('Filter By Day'),
            DropdownButton<int>(
              value: dateFilter,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  dateFilter = value;
                });
              },
              items: kDateFilterHabit.keys
                  .map(
                    (key) => DropdownMenuItem<int>(
                      value: key,
                      child: Text(
                        kDateFilterHabit[key],
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 12.0),
            Text('Filter By Habit'),
            DropdownButton<String>(
              value: habitFilter?.id ?? '',
              isExpanded: true,
              onChanged: (value) {
                if (!(value?.isEmpty ?? true)) {
                  setState(() {
                    habitFilter =
                        widget.habits.firstWhere((habit) => habit.id == value);
                  });
                } else {
                  habitFilter = null;
                }
              },
              items: <DropdownMenuItem<String>>[
                const DropdownMenuItem<String>(value: '', child: Text('All')),
                ...widget.habits
                    .map(
                      (habit) => DropdownMenuItem<String>(
                        value: habit.id,
                        child: Text(habit.name),
                      ),
                    )
                    .toList(),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          DiaryFilterDialogArguments(
                              dateFilter: dateFilter,
                              habitFilter: habitFilter));
                    },
                    child: const Text('OK')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiaryFilterDialogArguments {
  final int dateFilter;
  final Habit habitFilter;

  const DiaryFilterDialogArguments({
    @required this.dateFilter,
    @required this.habitFilter,
  });
}
