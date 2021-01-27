import 'package:flutter/material.dart';
import 'package:totodo/app_config.dart';

import 'presentation/my_app.dart';
import 'presentation/router.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(
    AppConfig(
      appName: "FindSeat",
      debugTag: false,
      flavorName: "prod",
      initialRoute: AppRouter.HOME,
      child: MyApp.runWidget(),
    ),
  );
}
