import 'package:flutter/material.dart';

import 'color_const.dart';

final kFontRegular = TextStyle(
    fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: kColorBlack);

final kFontMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: kColorBlack,
);

final kFontSemibold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: kColorBlack,
);

//REGULAR
final kFontRegularDefault = kFontRegular.copyWith(color: kColorPrimary);
final kFontRegularDefault_10 = kFontRegular.copyWith(fontSize: 10);
final kFontRegularDefault_12 = kFontRegular.copyWith(fontSize: 12);

final kFontRegularGray4 = kFontRegular.copyWith(color: kColorGray4);
final kFontRegularGray4_8 = kFontRegularGray4.copyWith(fontSize: 8);
final kFontRegularGray4_10 = kFontRegularGray4.copyWith(fontSize: 10);
final kFontRegularGray4_12 = kFontRegularGray4.copyWith(fontSize: 12);
final kFontRegularGray4_14 = kFontRegularGray4.copyWith(fontSize: 14);
