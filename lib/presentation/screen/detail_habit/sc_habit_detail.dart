import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:totodo/bloc/detail_habit/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/create_habit/container_info.dart';
import 'package:totodo/presentation/screen/detail_habit/chart_detail_habit.dart';
import 'package:totodo/presentation/screen/detail_habit/header_detail_habit.dart';
import 'package:totodo/presentation/screen/detail_habit/popup_menu_habit_detail.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

const kDataKey = 'data';
const kTitleKey = 'title';

class HabitDetailScreen extends StatefulWidget {
  static const kTypeHabit = 'habit';
  static const kTypeChosenDay = 'chosenDay';

  final Habit _habit;
  final String _chosenDay;

  const HabitDetailScreen(this._habit, this._chosenDay);

  @override
  _HabitDetailScreenState createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  final _controller = ScrollController();

  double maxHeight;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  DetailHabitBloc _detailHabitBloc;
  DetailHabitState _state;

  @override
  void initState() {
    maxHeight = 0;
    _detailHabitBloc =
        DetailHabitBloc(habitRepository: getIt<IHabitRepository>())
          ..add(InitDataDetailHabit(
              habit: widget._habit, chosenDay: widget._chosenDay));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailHabitBloc>(
      create: (context) => _detailHabitBloc,
      child: BlocConsumer<DetailHabitBloc, DetailHabitState>(
        listenWhen: (previous, current) =>
            previous.habit != null &&
                current.habit != null &&
                previous.habit?.isTrashed != current.habit?.isTrashed ||
            previous.habit?.isFinished != current.habit?.isFinished,
        listener: (context, state) {
          _state = state;
          if (state.habit?.isTrashed ??
              false || state.habit.isFinished ??
              false) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          _state = state;
          if (state.habit != null) {
            maxHeight = state.habit.isDoneOnDay(state.chosenDay)
                ? MediaQuery.of(context).size.height - 160
                : MediaQuery.of(context).size.height;
            return Scaffold(
              backgroundColor: kColorWhite,
              body: NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _snapAppbar();
                  return false;
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      stretch: true,
                      iconTheme: const IconThemeData(color: Colors.white),
                      actions: [
                        CircleInkWell(
                          Icons.menu_book,
                          size: 24.0,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRouter.kDiary,
                                arguments: {
                                  kDataKey: state.habit.id,
                                  kTitleKey: state.habit.name
                                });
                          },
                        ),
                        PopupMenuHabitDetail(
                          onEditHabit: _onEditHabit,
                          onDeleteHabit: _onDeleteHabit,
                          onArchiveHabit: _onArchiveHabit,
                        )
                      ],
                      flexibleSpace: HeaderDetailHabit(
                        maxHeight: maxHeight,
                        minHeight: minHeight,
                      ),
                      expandedHeight:
                          maxHeight - MediaQuery.of(context).padding.top,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        _buildRowInfo(),
                        _buildDivider(),
                        _buildCalendar(),
                        _buildDivider(),
                        _buildMonthlyCompletionRate(),
                        if (state.habit.typeHabitGoal ==
                            EHabitGoal.reachACertainAmount.index)
                          _buildDivider(),
                        if (state.habit.typeHabitGoal ==
                            EHabitGoal.reachACertainAmount.index)
                          _buildDailyGoals(),
                        if (state.habit.typeHabitGoal !=
                            EHabitGoal.reachACertainAmount.index)
                          SizedBox(
                            height: 80,
                          ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildRowInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  _state.theNumberOfDoneDays.toString(),
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Tổng ngày',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  _state.theLongestStreak.toString(),
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Streak dài nhất',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  _state.theCurrentStreak.toString(),
                  style: kFontMediumBlack_18,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Streak hiện tại',
                  style: kFontRegularGray1_12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month),
      ),
      pageJumpingEnabled: true,
      onPageChanged: (focusedDay) {
        log('testCalendar', focusedDay);
        // currentMonth = focusedDay.month;
      },
      focusedDay: DateTime.now(),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      availableGestures: AvailableGestures.none,
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          if (_state.habit.isDoneOnDay(day.toIso8601String())) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: kColorGreenLight),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: kColorWhite, fontSize: 14.0),
                ),
              ),
            );
          }
          return null;
        },
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              day.day.toString(),
              style: TextStyle(
                  color:
                      _state.habit.isDoneOnDay(DateTime.now().toIso8601String())
                          ? kColorWhite
                          : kColorPrimary,
                  fontSize: 14.0),
            ),
          );
        },
        rangeHighlightBuilder: (context, day, isWithinRange) {
          final frequency = _state.habit.frequency;

          final weekday =
              DateHelper.convertStandardWeekdayToCustomWeekday(day.weekday);

          final bool isInFrequency = !day.isAfter(DateTime.now()) &&
              (frequency.typeFrequency == EHabitFrequency.weekly.index ||
                  (frequency.typeFrequency == EHabitFrequency.daily.index &&
                      frequency.dailyDays.contains(weekday)));
          if (isInFrequency) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        height: 1.0,
      ),
    );
  }

  Widget _buildMonthlyCompletionRate() {
    return ContainerInfo(
      title: 'Tỉ lệ hoàn thành trong tháng ${DateTime.now().month}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${(_state.completedPercentByMonth * 100).toStringAsFixed(2)}%',
                style: kFontMediumBlack_18,
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(4.0),
                  // width: 240,
                  lineHeight: 6.0,
                  alignment: MainAxisAlignment.center,
                  percent: _state.completedPercentByMonth,
                  backgroundColor: Colors.grey[200],
                  progressColor: kColorPrimary,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Số ngày hoàn thành: ${_state.theNumberOfDoneDaysInMonth} ngày',
            style: kFontRegularGray1_12,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Steak dài nhất: ${_state.theLongestStreakInMonth} ngày',
            style: kFontRegularGray1_12,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Mục tiêu: ${_state.targetDays} ngày',
            style: kFontRegularGray1_12,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoals() {
    List<StepChartItem> listStepChartItem;
    // if (DateTime.now().day > 10) {
    listStepChartItem = [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        .map((days) => StepChartItem(
            DateTime.now().subtract(Duration(days: days)).day - 1,
            _state.habit.currentAmountOnDay(DateTime.now()
                .subtract(Duration(days: days))
                .toIso8601String())))
        .toList();
    // } else {
    //   listStepChartItem = List.generate(10, (index) => index + 1)
    //       .map((days) => StepChartItem(
    //           DateTime(DateTime.now().year, DateTime.now().month)
    //               .add(Duration(days: days))
    //               .day,
    //           _state.habit.currentAmountOnDay(DateTime.now()
    //               .subtract(Duration(days: days))
    //               .toIso8601String())))
    //       .toList();
    // }
    return ContainerInfo(
      title: 'Mục tiêu hằng ngày (Count)', //TODO change type Count => ...
      child: Container(
        height: 240.0,
        padding: const EdgeInsets.only(top: 8.0),
        child: ChartDetailHabit(
          target: _state.habit.missionDayTarget,
          listStepChartItem: listStepChartItem,
        ),
      ),
    );
  }

  Future<void> _onEditHabit() async {
    await Navigator.of(context)
        .pushNamed(AppRouter.kCreateHabit, arguments: _state.habit);
    _detailHabitBloc.add(UpdateDataDetailHabit());
  }

  void _onDeleteHabit() {
    _detailHabitBloc.add(DeleteHabit());
  }

  void _onArchiveHabit() {
    _detailHabitBloc.add(ArchiveHabit());
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}
