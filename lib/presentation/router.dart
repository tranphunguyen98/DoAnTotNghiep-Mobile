import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/select_label/bloc.dart';
import 'package:totodo/data/entity/habit/habit.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/create_habit/sc_create_habit.dart';
import 'package:totodo/presentation/screen/detail_habit/sc_habit_detail.dart';
import 'package:totodo/presentation/screen/diary/item_diary.dart';
import 'package:totodo/presentation/screen/diary/sc_diary.dart';
import 'package:totodo/presentation/screen/list_habit/sc_list_habit.dart';
import 'package:totodo/presentation/screen/profile/sc_profile.dart';
import 'package:totodo/presentation/screen/util/sc_loading.dart';

import 'screen/change_password/sc_change_password.dart';
import 'screen/creating_habit_list/sc_list_habit_creating.dart';
import 'screen/forgot_password/sc_forgot_password.dart';
import 'screen/home/sc_home.dart';
import 'screen/label/sc_add_label.dart';
import 'screen/login/sc_login.dart';
import 'screen/project/sc_add_project.dart';
import 'screen/select_label/sc_select_label.dart';
import 'screen/setting/sc_setting.dart';
import 'screen/signup/sc_signup.dart';
import 'screen/task_detail/sc_detail_task.dart';
import 'screen/util/sc_splash.dart';

class AppRouter {
  static const String kHome = '/home';
  static const String kSplash = '/splash';
  static const String kLoading = '/loading';
  static const String kLogin = '/login';
  static const String kSignUp = '/signUp';
  static const String kChangePassword = '/changePassword';
  static const String kForgotPassword = '/forgotPassword';
  static const String kSetting = '/setting';
  static const String kAddProject = '/addProject';
  static const String kAddLabel = '/addLabel';
  static const String kDetailTask = '/detailTask';
  static const String kSelectLabel = '/selectLabel';
  static const String kProfile = '/profile';
  static const String kCreatingHabitList = '/creatingHabitList';
  static const String kCreateHabit = '/createHabit';
  static const String kDetailHabit = '/detailHabit';
  static const String kListHabit = '/listHabit';
  static const String kDiary = '/diary';

  static const String kArgumentTask = '/argumentTask';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case kLoading:
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case kHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case kLogin:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case kSignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case kForgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case kChangePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case kSetting:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case kAddProject:
        return MaterialPageRoute(builder: (_) => AddProjectScreen());
      case kAddLabel:
        if (settings.arguments is Label) {
          return MaterialPageRoute(
              builder: (_) => AddLabelScreen(
                    label: settings.arguments as Label,
                  ));
        }
        return MaterialPageRoute(builder: (_) => const AddLabelScreen());
      case kProfile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case kCreatingHabitList:
        return MaterialPageRoute(builder: (_) => ListHabitCreatingScreen());
      case kListHabit:
        return MaterialPageRoute(builder: (_) => ListHabitScreen());
      case kDiary:
        return _buildDiaryScreen(settings);
        break;
      case kDetailHabit:
        if (settings.arguments is Map<String, Object>) {
          final habit = (settings.arguments
              as Map<String, Object>)[HabitDetailScreen.kTypeHabit] as Habit;
          final chosenDay = (settings.arguments
                  as Map<String, Object>)[HabitDetailScreen.kTypeChosenDay]
              as String;
          return MaterialPageRoute(
            builder: (_) => HabitDetailScreen(habit, chosenDay),
          );
        }
        break;
      case kCreateHabit:
        return _buildCreateHabitScreen(settings);
      case kSelectLabel:
        if (settings.arguments is List<Label>) {
          final listLabelSelected = settings.arguments as List<Label>;
          return MaterialPageRoute(
              builder: (_) => BlocProvider<SelectLabelBloc>(
                  create: (context) => SelectLabelBloc(
                        taskRepository: getIt<ITaskRepository>(),
                      ),
                  child: SelectLabelScreen(listLabelSelected)));
        }
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SelectLabelBloc>(
                create: (context) => SelectLabelBloc(
                      taskRepository: getIt<ITaskRepository>(),
                    ),
                child: const SelectLabelScreen()));
      case kDetailTask:
        if (settings.arguments is Task) {
          final task = settings.arguments as Task;
          return MaterialPageRoute(builder: (_) => ScreenDetailTask(task));
        } else {
          final taskId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => ScreenDetailTask(
              null,
              taskId: taskId,
            ),
          );
        }
        break;
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }

  static MaterialPageRoute _buildDiaryScreen(RouteSettings settings) {
    if (settings.arguments is List<DiaryItemData>) {
      return MaterialPageRoute(
          builder: (_) =>
              DiaryScreen(listData: settings.arguments as List<DiaryItemData>));
    }
    return MaterialPageRoute(builder: (_) => const DiaryScreen());
  }

  static MaterialPageRoute _buildCreateHabitScreen(RouteSettings settings) {
    CreateHabitScreen createHabitScreen;

    if (settings.arguments is Habit) {
      createHabitScreen = CreateHabitScreen(settings.arguments as Habit);
    } else {
      createHabitScreen = const CreateHabitScreen();
    }

    return MaterialPageRoute(builder: (_) => createHabitScreen);
  }
}
