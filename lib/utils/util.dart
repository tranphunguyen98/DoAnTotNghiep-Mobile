import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:totodo/di/injection.dart';

String getHexFromColor(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}';
}

void log(String name, Object msg) {
  getIt<Logger>().d('${DateFormat("HH:mm:ss").format(DateTime.now())}: $name\n'
      '$msg');
}

void dismissKeyboard(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
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
