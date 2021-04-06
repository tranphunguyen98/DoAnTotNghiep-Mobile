import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/repository_interface/i_task_repository.dart';
import 'package:totodo/bloc/select_label/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/profile/sc_profile.dart';

import 'screen/change_password/sc_change_password.dart';
import 'screen/create_habit/sc_list_habit_creating.dart';
import 'screen/forgot_password/sc_forgot_password.dart';
import 'screen/home/sc_home.dart';
import 'screen/label/sc_add_label.dart';
import 'screen/login/sc_login.dart';
import 'screen/project/sc_add_project.dart';
import 'screen/select_label/sc_select_label.dart';
import 'screen/setting/sc_setting.dart';
import 'screen/signup/sc_signup.dart';
import 'screen/splash/sc_splash.dart';
import 'screen/task_detail/sc_detail_task.dart';

class AppRouter {
  static const String kHome = '/home';
  static const String kSplash = '/splash';
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

  static const String kArgumentTask = '/argumentTask';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
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
        return MaterialPageRoute(builder: (_) => AddLabelScreen());
      case kProfile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case kCreatingHabitList:
        return MaterialPageRoute(builder: (_) => ListHabitCreatingScreen());

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
                child: SelectLabelScreen()));
        break;
        return MaterialPageRoute(builder: (_) => SelectLabelScreen());
      case kDetailTask:
        // print("kDetailTask: ${settings.arguments}");
        if (settings.arguments is Task) {
          final task = settings.arguments as Task;
          return MaterialPageRoute(builder: (_) => ScreenDetailTask(task));
        } else {
          // print("kDetailTask: ${settings.arguments as String}");

          final taskId = settings.arguments as String;
          return MaterialPageRoute(
              builder: (_) => ScreenDetailTask(
                    null,
                    taskId: taskId,
                  ));
        }
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
