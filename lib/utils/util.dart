import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/utils/my_const/map_const.dart';

import 'my_const/color_const.dart';

String getHexFromColor(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}';
}

void log(String name, [Object msg]) {
  getIt<Logger>().d(
      'AppTotodo: ${DateFormat("HH:mm:ss").format(DateTime.now())}: $name ${msg?.toString() ?? ''}');
}

void dismissKeyboard(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Color getColorDefaultFromValue(String value) {
  final dataColor = kListColorDefault
      .firstWhere((element) => element[keyListColorValue] as String == value);
  return dataColor[keyListColorColor] as Color;
}

Map<String, dynamic> getHabitTypeFromId(int id) {
  final mapHabitType =
      kHabitType.firstWhere((element) => element[kKeyHabitTypeId] as int == id);
  return mapHabitType;
}

// Function debounce(Function() func, int milliseconds) {
//   Timer timer;
//   return () {
//     // or (arg) if you need an argument
//     if (timer != null) {
//       timer.cancel();
//     }
//
//     timer =
//         Timer(Duration(milliseconds: milliseconds), func); // or () => func(arg)
//   };
// }
