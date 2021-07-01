import 'dart:io';

import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';
import 'package:totodo/utils/util.dart';

class ItemDiary extends StatelessWidget {
  final DiaryItemData data;

  const ItemDiary(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    data.date.day.toString(),
                    style: kFontSemiboldBlack_22,
                  ),
                  Container(
                    width: 24.0,
                    height: 4.0,
                    color: kColorBlueLight,
                  )
                ],
              ),
              SizedBox(width: 2.0),
              Text(
                "Tháng ${data.date.month}",
                style: kFontRegularBlack2_14,
              ),
              Spacer(),
              Image.asset(
                getOnEmotion(data.emotional),
                height: 24.0,
                width: 24.0,
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            data.title,
            style: kFontSemiboldBlack_16,
          ),
          SizedBox(
            height: 4.0,
          ),
          if (data.content != null)
            Text(
              data.content,
              style: kFontRegularBlack2_14,
            ),
          if (data.content != null)
            SizedBox(
              height: 8.0,
            ),
          if (!(data?.images?.isEmpty ?? true))
            Row(children: [
              ...data.images.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      File(e),
                      width: 80,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ]
                // data.images
                //     .map((e) => Image.asset(
                //           kImageMotivation,
                //           height: 64.0,
                //         ))
                //     .toList(),
                )
        ],
      ),
    );
  }
}

class DiaryItemData {
  final DateTime date;
  final String title;
  final String content;
  final List<String> images;
  final int emotional;

  const DiaryItemData({
    @required this.date,
    @required this.title,
    this.emotional,
    this.content,
    this.images,
  });

  DiaryItemData copyWith({
    DateTime date,
    String title,
    String content,
    List<String> images,
    int emotional,
  }) {
    if ((date == null || identical(date, this.date)) &&
        (title == null || identical(title, this.title)) &&
        (content == null || identical(content, this.content)) &&
        (images == null || identical(images, this.images)) &&
        (emotional == null || identical(emotional, this.emotional))) {
      return this;
    }

    return DiaryItemData(
      date: date ?? this.date,
      title: title ?? this.title,
      content: content ?? this.content,
      images: images ?? this.images,
      emotional: emotional ?? this.emotional,
    );
  }
}
