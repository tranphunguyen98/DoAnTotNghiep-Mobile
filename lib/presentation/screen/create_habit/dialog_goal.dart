import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DialogGoal extends StatefulWidget {
  @override
  _DialogGoalState createState() => _DialogGoalState();
}

class _DialogGoalState extends State<DialogGoal> {
  double heightContainer;
  int _radioValue = 0;
  String _dropDownValueUnit = kListUnitDailyGoal.first;
  String _dropDownValueMethod = kListCheckingType.first;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _amountOneTimeCheckController =
      TextEditingController();

  @override
  void initState() {
    _amountController.text = '1';
    _amountOneTimeCheckController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_radioValue == 0) {
      heightContainer = 222.0;
    } else {
      if (_dropDownValueMethod == kListCheckingType[0]) {
        heightContainer = 366.0;
      } else {
        heightContainer = 334.0;
      }
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                    groupValue: _radioValue,
                    onChanged: (int value) {
                      _onRadioChanged(value);
                    },
                  ),
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
                    groupValue: _radioValue,
                    onChanged: (int value) {
                      _onRadioChanged(value);
                    },
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Hoàn thành theo số lượng nhất định',
                    style: kFontRegularBlack2_14,
                  ),
                ],
              ),
              if (_radioValue == 1) _buildSelectGoalCertainAmount(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _onRadioChanged(int value) {
    setState(() {
      _radioValue = value;
    });
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
          if (_dropDownValueMethod == kListCheckingType[0])
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
              controller: _amountController,
              textStyle: kFontRegularBlack2_14,
              hint: '',
              autoFocus: false,
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
          child: DropdownButton<String>(
            value: _dropDownValueUnit,
            isExpanded: true,
            underline: Container(),
            items: kListUnitDailyGoal.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: kFontRegularBlack2_12,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _dropDownValueUnit = newValue;
              });
            },
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
          child: DropdownButton<String>(
            value: _dropDownValueMethod,
            isExpanded: true,
            underline: Container(),
            items: kListCheckingType.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: kFontRegularBlack2_12,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _dropDownValueMethod = newValue;
              });
            },
          ),
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
            textStyle: kFontRegularBlack2_14,
            hint: '',
            autoFocus: false,
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
            onPressed: () {},
            child: Text(
              'CANCEL',
              style: kFontMediumDefault_14,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'OK',
              style: kFontMediumDefault_14,
            ),
          ),
        ],
      ),
    );
  }
}
