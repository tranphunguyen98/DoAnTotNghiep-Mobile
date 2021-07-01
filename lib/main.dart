import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/local/source/habit/local_habit_service.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/utils/notification_helper.dart';

import 'app_config.dart';
import 'data/local/model/local_task.dart';
import 'data/local/source/habit/local_diary_service.dart';
import 'data/local/source/task/local_task_service.dart';
import 'data/model/check_item.dart';
import 'data/model/habit/diary_item.dart';
import 'data/model/habit/diary_item.dart';
import 'data/model/habit/habit.dart';
import 'data/model/habit/habit_frequency.dart';
import 'data/model/habit/habit_icon.dart';
import 'data/model/habit/habit_image.dart';
import 'data/model/habit/habit_motivation.dart';
import 'data/model/habit/habit_progress_item.dart';
import 'data/model/habit/habit_remind.dart';
import 'data/model/label.dart';
import 'data/model/project.dart';
import 'data/model/section.dart';
import 'di/injection.dart';
import 'presentation/my_app.dart';
import 'presentation/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init Hive
  await _initHive();

  MyApp.initSystemDefault();
  await configureDependencies();

  initNotification();
  // await AwesomeNotifications().cancelAllSchedules();

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

  //Task
  Hive.registerAdapter<LocalTask>(LocalTaskAdapter());
  Hive.registerAdapter<Project>(ProjectAdapter());
  Hive.registerAdapter<Label>(LabelAdapter());
  Hive.registerAdapter<CheckItem>(CheckItemAdapter());
  Hive.registerAdapter<Section>(SectionAdapter());
  await Hive.openBox(LocalTaskService.kNameBoxTask);
  await Hive.openBox(LocalTaskService.kNameBoxProject);
  await Hive.openBox(LocalTaskService.kNameBoxLabel);
  // Habit
  Hive.registerAdapter<Diary>(DiaryAdapter());
  Hive.registerAdapter<HabitFrequency>(HabitFrequencyAdapter());
  Hive.registerAdapter<HabitIcon>(HabitIconAdapter());
  Hive.registerAdapter<HabitImage>(HabitImageAdapter());
  Hive.registerAdapter<HabitMotivation>(HabitMotivationAdapter());
  Hive.registerAdapter<HabitProgressItem>(HabitProgressItemAdapter());
  Hive.registerAdapter<HabitRemind>(HabitRemindAdapter());
  Hive.registerAdapter<Habit>(HabitAdapter());

  await Hive.openBox(LocalHabitService.kNameBoxHabit);
  await Hive.openBox(LocalDiaryService.kNameBoxDiary);
}
