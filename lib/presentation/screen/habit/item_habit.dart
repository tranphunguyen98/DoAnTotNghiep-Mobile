import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemHabit extends StatelessWidget {
  final String image;
  final String title;
  final String unit;
  final int totalDay;

  const ItemHabit({
    @required this.image,
    @required this.title,
    @required this.unit,
    @required this.totalDay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 48,
            height: 48,
          ),
          SizedBox(
            width: 16.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kFontMediumBlack_14,
              ),
              if (unit != null)
                Row(
                  children: [
                    Text(
                      unit,
                      style: kFontRegularGray1_12,
                    ),
                  ],
                )
            ],
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalDay.toString(),
                style: kFontMediumBlack_14,
              ),
              Text(
                'Tổng ngày',
                style: kFontRegularGray1_12,
              )
            ],
          ),
        ],
      ),
    );
  }
}
