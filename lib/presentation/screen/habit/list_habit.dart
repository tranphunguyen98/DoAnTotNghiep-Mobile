import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/habit/item_habit.dart';
import 'package:totodo/utils/my_const/asset_const.dart';

class ListHabit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ItemHabit(
          image: kIconMeditation, title: 'Thiền', unit: '5/10', totalDay: 10),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Divider(
          height: 1.0,
        ),
      ),
      itemCount: 10,
    );
  }
}
