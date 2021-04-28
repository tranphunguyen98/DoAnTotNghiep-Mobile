import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class DiaryScreen extends StatelessWidget {
  final List<ItemDiaryData> listData;
  final String title;

  const DiaryScreen(this.listData, {this.title});

  @override
  Widget build(BuildContext context) {
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
                title ?? "Diary",
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              background: Image.asset(
                kBackgroundDiary,
                fit: BoxFit.cover,
              )),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 16.0,
            ),
            ...listData.map((e) => ItemDiary(e)).toList(),
            ...listData.map((e) => ItemDiary(e)).toList(),
            ...listData.map((e) => ItemDiary(e)).toList(),
            ...listData.map((e) => ItemDiary(e)).toList(),
          ]),
        ),
      ]),
    );
  }
}
