import 'package:flutter/material.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_avatar_asset.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class HeaderMainDrawer extends StatelessWidget {
  final User user;
  const HeaderMainDrawer({this.user});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: kColorPrimary,
        ),
        child: Row(
          children: [
            CircleAvatarAsset(
              size: 40,
              assetImageUrl: user.avatar,
            ),
            SizedBox(width: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: kFontMediumWhite_14,
                  textAlign: TextAlign.start,
                ),
                Text(user.email, style: kFontRegularWhite_12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
