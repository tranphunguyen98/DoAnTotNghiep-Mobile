import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:totodo/data/entity/check_item.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/local/model/local_task.dart';

import 'app_config.dart';
import 'data/entity/label.dart';
import 'data/entity/section.dart';
import 'data/local/model/local_task.dart';
import 'data/local/source/task/local_task_service.dart';
import 'di/injection.dart';
import 'presentation/my_app.dart';
import 'presentation/router.dart';

Future<void> main() async {
  print("main");
  WidgetsFlutterBinding.ensureInitialized();

  //Init Hive
  await _initHive();

  MyApp.initSystemDefault();
  await configureDependencies();

  //print("Box OPEN");
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

Future _initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter<LocalTask>(LocalTaskAdapter());
  Hive.registerAdapter<Project>(ProjectAdapter());
  Hive.registerAdapter<Label>(LabelAdapter());
  Hive.registerAdapter<Section>(SectionAdapter());
  Hive.registerAdapter<CheckItem>(CheckItemAdapter());
  await Hive.openBox(LocalTaskService.kNameBoxTask);
  await Hive.openBox(LocalTaskService.kNameBoxProject);
  await Hive.openBox(LocalTaskService.kNameBoxLabel);
}
