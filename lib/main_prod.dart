import 'package:flutter/material.dart';
import 'package:totodo/app_config.dart';

import 'presentation/my_app.dart';
import 'presentation/router.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(
    AppConfig(
      appName: "ToToDo",
      debugTag: false,
      flavorName: "prod",
      initialRoute: AppRouter.kLogin,
      child: MyApp.runWidget(),
    ),
  );
}
