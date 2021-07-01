import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/create_habit/bloc.dart';
import 'package:totodo/bloc/create_habit/create_habit_bloc.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DialogGoal extends StatefulWidget {
  @override
  _DialogGoalState createState() => _DialogGoalState();
}

class _DialogGoalState extends State<DialogGoal> {
  CreateHabitBloc _createHabitBloc;
  CreateHabitState _state;

  double heightContainer;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountOneTimeCheckController =
      TextEditingController();

  @override
  void initState() {
    _createHabitBloc = BlocProvider.of<CreateHabitBloc>(context);
    _amountController.text =
        _createHabitBloc.state.habit.missionDayTarget.toString();
    _amountOneTimeCheckController.text =
        _createHabitBloc.state.habit.missionDayCheckInStep.toString();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateHabitBloc, CreateHabitState>(
      cubit: _createHabitBloc,
      builder: (context, state) {
        _state = state;
        if (_state.habit.typeHabitGoal == EHabitGoal.archiveItAll.index) {
          heightContainer = 222.0;
        } else {
          if (state.habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.auto.index) {
            heightContainer = 366.0;
          } else {
            heightContainer = 334.0;
          }
        }
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SingleChildScrollView(
            child: Container(
              height: heightContainer,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Mục tiêu',
                      style: kFontMediumBlack_16,
                    ),
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 0,
                          groupValue: _state.habit.typeHabitGoal,
                          onChanged: _onRadioChanged),
                      SizedBox(width: 8.0),
                      Text(
                        'Hoàn thành trong 1 lần',
                        style: kFontRegularBlack2_14,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: _state.habit.typeHabitGoal,
                          onChanged: _onRadioChanged),
                      SizedBox(width: 8.0),
                      Text(
                        'Hoàn thành theo số lượng nhất định',
                        style: kFontRegularBlack2_14,
                      ),
                    ],
                  ),
                  if (_state.habit.typeHabitGoal ==
                      EHabitGoal.reachACertainAmount.index)
                    _buildSelectGoalCertainAmount(),
                  _buildButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectGoalCertainAmount() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.0,
          ),
          _buildRowSelectUnit(),
          SizedBox(
            height: 16.0,
          ),
          _buildRowSelectMethod(),
          SizedBox(
            height: 16.0,
          ),
          if (_state.habit.typeHabitMissionDayCheckIn ==
              EHabitMissionDayCheckIn.auto.index)
            _buildRowAmountOneTimeCheck(),
        ],
      ),
    );
  }

  Widget _buildRowSelectUnit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Daily',
          style: kFontRegularBlack2_14,
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            height: 32.0,
            margin: EdgeInsets.only(right: 8.0),
            padding: EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4.0)),
            child: TextFieldNonBorder(
              keyboardType: TextInputType.number,
              controller: _amountController,
              textStyle: kFontRegularBlack2_14,
              hint: '',
              autoFocus: false,
              onChanged: _onHabitTotalAmountChanged,
            ),
          ),
        ),
        Container(
          width: 136.0,
          height: 32.0,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.0)),
          padding: EdgeInsets.only(left: 8.0),
          child: DropdownButton<int>(
            value: _state.habit.missionDayUnit,
            isExpanded: true,
            underline: Container(),
            items: kHabitMissionDayUnit.keys.map((value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  kHabitMissionDayUnit[value],
                  style: kFontRegularBlack2_12,
                ),
              );
            }).toList(),
            onChanged: _onHabitMissionDayUnitChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildRowSelectMethod() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Cách hoàn thành',
          style: kFontRegularBlack2_14,
        ),
        Spacer(),
        Container(
          width: 136.0,
          height: 32.0,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.0)),
          padding: EdgeInsets.only(left: 8.0),
          child: DropdownButton<int>(
              value: _state.habit.typeHabitMissionDayCheckIn,
              isExpanded: true,
              underline: Container(),
              items: kHabitMissionDayCheckIn.keys.map((value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    kHabitMissionDayCheckIn[value],
                    style: kFontRegularBlack2_12,
                  ),
                );
              }).toList(),
              onChanged: _onHabitMissionDayCheckInChanged),
        ),
      ],
    );
  }

  Widget _buildRowAmountOneTimeCheck() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Số lượng 1 lần check',
          style: kFontRegularBlack2_14,
        ),
        Spacer(),
        Container(
          width: 136.0,
          height: 32.0,
          padding: EdgeInsets.only(top: 4.0),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.0)),
          child: TextFieldNonBorder(
            controller: _amountOneTimeCheckController,
            keyboardType: TextInputType.number,
            textStyle: kFontRegularBlack2_14,
            hint: '',
            autoFocus: false,
            onChanged: _onMissionDayCheckInStepChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _onOk,
            child: Text(
              'CANCEL',
              style: kFontMediumDefault_14,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          TextButton(
            onPressed: _onOk,
            child: Text(
              'OK',
              style: kFontMediumDefault_14,
            ),
          ),
        ],
      ),
    );
  }

  void _onOk() {
    Navigator.of(context).pop();
  }

  void _onHabitMissionDayUnitChanged(int unit) {
    _createHabitBloc.add(CreatingHabitDataChanged(missionDayUnit: unit));
  }

  void _onRadioChanged(int value) {
    _createHabitBloc.add(CreatingHabitDataChanged(typeHabitGoal: value));
  }

  void _onHabitTotalAmountChanged(String value) {
    _createHabitBloc
        .add(CreatingHabitDataChanged(missionDayTarget: int.parse(value)));
  }

  void _onMissionDayCheckInStepChanged(String value) {
    _createHabitBloc
        .add(CreatingHabitDataChanged(missionDayCheckInStep: int.parse(value)));
  }

  void _onHabitMissionDayCheckInChanged(int value) {
    _createHabitBloc
        .add(CreatingHabitDataChanged(typeHabitMissionDayCheckIn: value));
  }
}
