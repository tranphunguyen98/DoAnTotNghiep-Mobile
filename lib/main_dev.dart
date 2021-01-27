import 'package:flutter/material.dart';

import 'app_config.dart';
import 'presentation/my_app.dart';
import 'presentation/router.dart';

void main() {
  MyApp.initSystemDefault();

  runApp(
    AppConfig(
      appName: "FindSeat Dev",
      debugTag: true,
      flavorName: "dev",
      initialRoute: AppRouter.HOME,
      child: MyApp.runWidget(),
    ),
  );
}
