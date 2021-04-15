import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:totodo/bloc/create_habit/bloc.dart';
import 'package:totodo/data/entity/habit/habit_remind.dart';
import 'package:totodo/presentation/custom_ui/custom_check_box.dart';
import 'package:totodo/presentation/custom_ui/custom_radio.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/create_habit/creating_habit_step.dart';
import 'package:totodo/presentation/screen/create_habit/dialog_goal.dart';
import 'package:totodo/presentation/screen/create_habit/item_reminder_habit.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class BodyCreatingHabitStep2 extends StatefulWidget {
  @override
  _BodyCreatingHabitStep2State createState() => _BodyCreatingHabitStep2State();
}

class _BodyCreatingHabitStep2State extends State<BodyCreatingHabitStep2> {
  CreateHabitBloc _createHabitBloc;
  CreateHabitState _state;
  double valueInterval = 2;

  @override
  void initState() {
    _createHabitBloc = BlocProvider.of<CreateHabitBloc>(context);
    valueInterval =
        _createHabitBloc.state.habit.frequency.intervalDays.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateHabitBloc, CreateHabitState>(
      builder: (context, state) {
        _state = state;
        return WillPopScope(
          onWillPop: () async {
            Provider.of<CreatingHabitStep>(context, listen: false).index =
                CreatingHabitStep.kStep1;
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFrequency(),
                if (state.habit.frequency.typeFrequency ==
                    EHabitFrequency.daily.index)
                  _buildDailyFrequency(),
                if (state.habit.frequency.typeFrequency ==
                    EHabitFrequency.weekly.index)
                  _buildWeeklyFrequency(),
                if (state.habit.frequency.typeFrequency ==
                    EHabitFrequency.interval.index)
                  _buildIntervalFrequency(),
                _buildGoal(),
                _buildReminder(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFrequency() {
    return ContainerInfo(
      title: 'Tần suất thói quen',
      child: GroupRadioButton<int>(
          data: kHabitFrequency.keys
              .map((key) => RadioModel(kHabitFrequency[key], key))
              .toList(),
          defaultSelected: _state.habit.frequency.typeFrequency,
          onRadioValueChanged: _onTypeFrequencyHabitChanged),
    );
  }

  Widget _buildDailyFrequency() {
    return ContainerInfo(
      title: 'Chọn ngày',
      child: GroupCheckBoxButton<int>(
        data: kDailyDays.keys
            .map((key) => CheckBoxModel<int>(
                text: kDailyDays[key],
                data: key,
                isCheck: _state.habit.frequency.dailyDays.contains(key)))
            .toList(),
        onValuesChanged: _onDailyFrequencyChanged,
      ),
    );
  }

  Widget _buildWeeklyFrequency() {
    return ContainerInfo(
      title: 'Chọn số ngày trong tuần',
      child: GroupRadioButton<int>(
          data: kListWeeklyDays
              .map((e) => RadioModel<int>(e.toString(), e))
              .toList(),
          defaultSelected: _state.habit.frequency.weeklyDays,
          itemWidth: 56.0,
          onRadioValueChanged: _onWeeklyFrequencyHabitChanged),
    );
  }

  Widget _buildIntervalFrequency() {
    return ContainerInfo(
        title: 'Mỗi ${valueInterval.toInt()} ngày',
        child: Column(
          children: [
            Slider(
              value: valueInterval,
              min: 2,
              max: 30,
              onChangeEnd: _onIntervalFrequencyHabitChanged,
              onChanged: (double value) {
                setState(() {
                  valueInterval = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [Text('2'), Spacer(), Text('30')],
              ),
            )
          ],
        ));
  }

  Widget _buildGoal() {
    final textGoal = _state.habit.typeHabitGoal == EHabitGoal.archiveItAll.index
        ? 'Hoàn thành trong 1 lần'
        : '${_state.habit.totalDayAmount} ${kHabitMissionDayUnit[_state.habit.missionDayUnit]} mỗi ngày';
    return ContainerInfo(
        title: 'Mục tiêu',
        child: SizedBox(
          height: 48,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(textGoal),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: kColorBlack_30,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return BlocProvider<CreateHabitBloc>.value(
                            value: _createHabitBloc,
                            child: DialogGoal(),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildReminder() {
    return ContainerInfo(
      title: 'Nhắc nhở',
      child: Wrap(
        children: [
          ..._state.habit.reminds
              .map((e) => ItemReminderHabit(
                    text: DateFormat("HH:mm")
                        .format(DateTime(0, 0, 0, e.hour, e.minute)),
                  ))
              .toList(),
          GestureDetector(
            onTap: () async {
              final picker = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 9, minute: 0),
              );
              if (picker != null) {
                _onHabitRemindsChanged(
                    HabitRemind(hour: picker.hour, minute: picker.minute));
              }
            },
            child: Container(
              height: 36.0,
              width: 86.0,
              margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 24.0,
                  color: kColorGray4_40,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(color: kColorGray4_40),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTypeFrequencyHabitChanged(int type) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        frequency: _state.habit.frequency.copyWith(typeFrequency: type),
      ),
    );
  }

  void _onDailyFrequencyChanged(List<int> days) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        frequency: _state.habit.frequency.copyWith(dailyDays: days),
      ),
    );
  }

  void _onWeeklyFrequencyHabitChanged(int days) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        frequency: _state.habit.frequency.copyWith(weeklyDays: days),
      ),
    );
  }

  void _onIntervalFrequencyHabitChanged(double days) {
    _createHabitBloc.add(
      CreatingHabitDataChanged(
        frequency: _state.habit.frequency.copyWith(intervalDays: days.toInt()),
      ),
    );
  }

  void _onHabitRemindsChanged(HabitRemind habitRemind) {
    final reminds = <HabitRemind>[];
    reminds.addAll(_state.habit.reminds);
    reminds.add(habitRemind);
    _createHabitBloc.add(
      CreatingHabitDataChanged(reminds: reminds),
    );
  }
}
