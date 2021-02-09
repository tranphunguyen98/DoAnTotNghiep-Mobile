import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/change_password/sc_change_password.dart';
import 'package:totodo/presentation/screen/forgot_password/sc_forgot_password.dart';
import 'package:totodo/presentation/screen/home/sc_home.dart';
import 'package:totodo/presentation/screen/login/sc_login.dart';
import 'package:totodo/presentation/screen/setting/sc_setting.dart';
import 'package:totodo/presentation/screen/signup/sc_signup.dart';
import 'package:totodo/presentation/screen/splash/sc_splash.dart';

class AppRouter {
  static const String kHome = '/';
  static const String kSplash = '/splash';
  static const String kLogin = '/login';
  static const String kSignUp = '/signUp';
  static const String kChangePassword = '/changePassword';
  static const String kForgotPassword = '/forgotPassword';
  static const String kSetting = '/setting';

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
