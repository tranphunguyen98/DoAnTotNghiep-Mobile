import 'package:flutter/material.dart';

import 'app_config.dart';
import 'di/injection.dart';
import 'presentation/my_app.dart';
import 'presentation/router.dart';

Future<void> main() async {
  print("main");
  WidgetsFlutterBinding.ensureInitialized();
  MyApp.initSystemDefault();
  await configureDependencies();
  print("runApp");
  runApp(
    AppConfig(
      appName: "ToToDo Dev",
      debugTag: true,
      flavorName: "dev",
      initialRoute: AppRouter.kSignUp,
      child: MyApp.runWidget(),
    ),
  );
}
