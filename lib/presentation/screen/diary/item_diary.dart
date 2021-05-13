import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

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
                kIconHappy,
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
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                kImageMotivation,
                height: 80.0,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                kImageMotivation,
                height: 80.0,
              ),
            ),
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
}
