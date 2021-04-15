import 'package:flutter/material.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/creating_habit_list/list_habit_creating.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/map_const.dart';
import 'package:totodo/utils/util.dart';

class ListHabitCreatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColorWhite,
          title: Text(
            'Tạo thói quen',
            style: kFontMediumBlack_18,
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: kColorGray1,
            tabs: [
              Tab(
                text: 'GỢI Ý',
              ),
              Tab(
                text: 'CUỘC SỐNG',
              ),
              Tab(
                text: 'SỨC KHỎE',
              ),
              Tab(
                text: 'THỂ THAO',
              ),
              Tab(
                text: 'SỰ NGHIỆP',
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  CreatingHabitList(
                    listHabit: kListHabitDefault,
                  ),
                  CreatingHabitList(
                    listHabit: kListHabitDefault,
                  ),
                  CreatingHabitList(
                    listHabit: kListHabitDefault,
                  ),
                  CreatingHabitList(
                    listHabit: kListHabitDefault,
                  ),
                  CreatingHabitList(
                    listHabit: kListHabitDefault,
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: kColorWhite,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await Navigator.of(context)
                      .pushNamed(AppRouter.kCreateHabit);
                  log('success' * 100, success);
                  if (success is bool && success) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Tạo Thói Quen Mới',
                  style: kFontMediumWhite_12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
