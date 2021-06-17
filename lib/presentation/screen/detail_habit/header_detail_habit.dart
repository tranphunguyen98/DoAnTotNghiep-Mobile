import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/screen/detail_habit/dialog_complete_habit.dart';
import 'package:totodo/presentation/screen/detail_habit/slide_to_confirm.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class HeaderDetailHabit extends StatefulWidget {
  final double maxHeight;
  final double minHeight;

  const HeaderDetailHabit({Key key, this.maxHeight, this.minHeight})
      : super(key: key);

  @override
  _HeaderDetailHabitState createState() => _HeaderDetailHabitState();
}

class _HeaderDetailHabitState extends State<HeaderDetailHabit> {
  BuildContext _context;
  DetailHabitBloc _detailHabitBloc;
  DetailHabitState _state;

  @override
  void initState() {
    _detailHabitBloc = BlocProvider.of<DetailHabitBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return BlocConsumer<DetailHabitBloc, DetailHabitState>(
      cubit: _detailHabitBloc,
      listenWhen: (previous, current) =>
          previous.habit.isDoneOnDay(previous.chosenDay) !=
          current.habit.isDoneOnDay(previous.chosenDay),
      listener: (context, state) {
        if (state.habit.isDoneOnDay(state.chosenDay)) {
          _showDialogAddDiary();
        }
      },
      builder: (context, state) {
        _state = state;
        return LayoutBuilder(
          builder: (context, constraints) {
            final expandRatio = _calculateExpandRatio(constraints);
            final animation = AlwaysStoppedAnimation(expandRatio);
            return _buildContainerCheck();
          },
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio = (constraints.maxHeight - widget.minHeight) /
        (widget.maxHeight - widget.minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomLeft, end: Alignment.bottomCenter)
          .evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(bottom: 16, left: 64, right: 64.0),
        child: Text(
          "Thiền",
          style: TextStyle(
            fontSize: Tween<double>(begin: 18, end: 24).evaluate(animation),
            color: ColorTween(begin: Colors.black87, end: Colors.white)
                .evaluate(animation),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOpacity(Animation<double> animation) {
    return Opacity(
      opacity: Tween<double>(begin: 1, end: 0.0).evaluate(animation),
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Widget _buildContainerCheck() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: kColorGreenLight,
      height: MediaQuery.of(_context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:
                  !_state.habit.isDoneOnDay(_state.chosenDay) ? 220.0 : 180.0,
            ),
            Image.asset(
              kImageTag,
              width: 160.0,
              height: 160.0,
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              _state.habit.name,
              style: kFontSemiboldWhite_18,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              _state.habit.motivation.text,
              style: kFontRegularWhite_14_80,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.0,
            ),
            if (!_state.habit.isDoneOnDay(_state.chosenDay))
              ConfirmationSlider(
                onConfirmation: _onCheckInHabit,
                height: 56.0,
                text: '',
                backgroundColor: Colors.white.withOpacity(0.3),
                foregroundColor: Colors.white,
                iconColor: kColorGreenLight,
              ),
            SizedBox(
              height: 32.0,
            ),
            if (_state.habit.typeHabitGoal ==
                EHabitGoal.reachACertainAmount.index)
              LinearPercentIndicator(
                padding: EdgeInsets.all(4.0),
                width: 120.0,
                lineHeight: 6.0,
                alignment: MainAxisAlignment.center,
                percent: _state.habit.currentAmountOnDay(_state.chosenDay) /
                    _state.habit.totalDayAmount,
                backgroundColor: Colors.white.withOpacity(0.3),
                progressColor: Colors.white,
              ),
            SizedBox(
              height: 8.0,
            ),
            if (_state.habit.typeHabitGoal ==
                EHabitGoal.reachACertainAmount.index)
              Text(
                "${_state.habit.currentAmountOnDay(_state.chosenDay)}/${_state.habit.totalDayAmount} ${kHabitMissionDayUnit[_state.habit.missionDayUnit]}",
                style: kFontRegularWhite_12_80,
                textAlign: TextAlign.center,
              ),
            if (!_state.habit.isDoneOnDay(_state.chosenDay))
              SizedBox(
                height: _state.habit.typeHabitGoal ==
                        EHabitGoal.reachACertainAmount.index
                    ? 24.0
                    : 40.0,
              ),
            if (!_state.habit.isDoneOnDay(_state.chosenDay))
              CircleInkWell(
                Icons.keyboard_arrow_up,
                onPressed: () {},
                color: kColorWhite,
                size: 36.0,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCheckInHabit() async {
    _detailHabitBloc.add(CheckInHabit());
  }

  Future<void> _showDialogAddDiary() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return DialogCompleteHabit(_state.habit.name);
      },
    );
    _detailHabitBloc
        .add(AddDiary(DiaryItem(text: result, images: []), _state.chosenDay));
  }
}
