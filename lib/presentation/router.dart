import 'package:flutter/material.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/change_password/sc_change_password.dart';
import 'package:totodo/presentation/screen/forgot_password/sc_forgot_password.dart';
import 'package:totodo/presentation/screen/home/sc_home.dart';
import 'package:totodo/presentation/screen/label/sc_add_label.dart';
import 'package:totodo/presentation/screen/label/sc_select_label.dart';
import 'package:totodo/presentation/screen/login/sc_login.dart';
import 'package:totodo/presentation/screen/project/sc_add_project.dart';
import 'package:totodo/presentation/screen/setting/sc_setting.dart';
import 'package:totodo/presentation/screen/signup/sc_signup.dart';
import 'package:totodo/presentation/screen/splash/sc_splash.dart';
import 'package:totodo/presentation/screen/task/sc_detail_task.dart';

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
        final task = settings.arguments as Task;
        return MaterialPageRoute(builder: (_) => ScreenDetailTask(task));
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
