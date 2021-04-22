import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ItemDiary extends StatelessWidget {
  final String text;

  ItemDiary(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 8.0,
                color: kColorGreenLight,
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                'Ngày 15 tháng 04',
                style: kFontRegularGray1_12,
              ),
              SizedBox(
                width: 4.0,
              ),
              Icon(
                Icons.mood,
                size: 20.0,
                color: Colors.amberAccent,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 8.0, top: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: kFontRegularBlack2_14,
                ),
                SizedBox(
                  height: 8.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    kImageMotivation,
                    width: 240,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
