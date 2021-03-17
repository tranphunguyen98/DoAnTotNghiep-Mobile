import 'package:flutter/material.dart';
import '../data/entity/task.dart';
import 'screen/change_password/sc_change_password.dart';
import 'screen/forgot_password/sc_forgot_password.dart';
import 'screen/home/sc_home.dart';
import 'screen/label/sc_add_label.dart';
import 'screen/label/sc_select_label.dart';
import 'screen/login/sc_login.dart';
import 'screen/project/sc_add_project.dart';
import 'screen/setting/sc_setting.dart';
import 'screen/signup/sc_signup.dart';
import 'screen/splash/sc_splash.dart';
import 'screen/task/sc_detail_task.dart';

class AppRouter {
  static const String kHome = '/';
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
      case kSelectLabel:
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
