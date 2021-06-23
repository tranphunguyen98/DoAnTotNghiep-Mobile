import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/diary/bloc.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';
import 'package:totodo/presentation/screen/task/widget_empty_data.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import 'diary_filter_dialog.dart';

class DiaryScreen extends StatefulWidget {
  final List<DiaryItemData> listData;
  final String title;

  const DiaryScreen({this.listData, this.title});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  DiaryBloc _diaryBloc;
  DiaryState _state;

  @override
  void initState() {
    _diaryBloc = DiaryBloc(
      habitRepository: getIt.get<IHabitRepository>(),
    )..add(InitDataDiary(diaries: widget.listData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryBloc, DiaryState>(
      cubit: _diaryBloc,
      builder: (context, state) {
        _state = state;
        final tempDiary = state.diaries;
        if (tempDiary.isNotEmpty) {
          tempDiary[0] = tempDiary[0]
              .copyWith(images: [kImageMotivationArm, kImageMotivationGym]);
        }
        return Scaffold(
          backgroundColor: kColorBlueLight,
          body: CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160.0,
              backgroundColor: kColorBlueLight,
              iconTheme: IconThemeData(color: Colors.black87),
              foregroundColor: Colors.redAccent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  getTitle(),
                  style: TextStyle(color: Colors.black87),
                ),
                centerTitle: true,
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        kBackgroundDiary,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                CircleInkWell(
                  Icons.filter_list,
                  size: 24.0,
                  color: Colors.black,
                  onPressed: () async {
                    _showDialog(context);
                  },
                ),
              ],
            ),
            if (!(tempDiary.isEmpty ?? true))
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 16.0,
                  ),
                  ...state.diaries.map((e) => ItemDiary(e)).toList()
                ]),
              ),
            if (state.diaries?.isEmpty ?? true)
              const SliverFillRemaining(
                child: EmptyData('Danh sách nhật ký rống!'),
              )
          ]),
        );
      },
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    final result = await showDialog<DiaryFilterDialogArguments>(
      context: context,
      builder: (BuildContext dialogContext) {
        return DiaryFilterDialog(
          dateFilter: _state.dateFilter,
          habitFilter: _state.habitFilter,
          habits: _state.habits,
        );
      },
    );
    _diaryBloc.add(
      FilterChanged(
        dateFilter: result.dateFilter,
        habitFilter: result.habitFilter,
      ),
    );
  }

  String getTitle() {
    String title = "";
    if (_state.habitFilter != null) {
      title += _state.habitFilter.name;
      if (_state.dateFilter != DiaryState.kFilterDateNoDate) {
        title += " - ";
      }
    }

    if (_state.dateFilter != DiaryState.kFilterDateNoDate) {
      title += kDateFilterHabit[_state.dateFilter];
    }

    return title;
  }
}
