import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/local/task/local_task_service.dart';

import 'app_config.dart';
import 'data/entity/task.dart';
import 'di/injection.dart';
import 'presentation/my_app.dart';
import 'presentation/router.dart';

Future<void> main() async {
  print("main");
  WidgetsFlutterBinding.ensureInitialized();

  //Init Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  MyApp.initSystemDefault();
  await configureDependencies();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Project>(ProjectAdapter());
  await Hive.openBox(LocalTaskService.kNameBoxTask);
  await Hive.openBox(LocalTaskService.kNameBoxProject);

  print("Box OPEN");
  print("runApp");
  runApp(
    AppConfig(
      appName: "ToToDo Dev",
      debugTag: true,
      flavorName: "dev",
      initialRoute: AppRouter.kSplash,
      child: MyApp.runWidget(),
    ),
  );
}
