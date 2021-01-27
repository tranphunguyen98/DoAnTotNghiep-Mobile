import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class WidgetLogoToToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo_totodo.svg',
      color: kColorWhite,
      height: 70,
    );
  }
}
