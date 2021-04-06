import 'package:flutter/material.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemCreatingHabit extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String quote;

  const ItemCreatingHabit({
    @required this.imageUrl,
    @required this.title,
    @required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.kCreateHabit);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kFontRegular,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  quote,
                  style: kFontRegularBlack2_12,
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.add,
              size: 28,
              color: kColorBlack_30,
            )
          ],
        ),
      ),
    );
  }
}
