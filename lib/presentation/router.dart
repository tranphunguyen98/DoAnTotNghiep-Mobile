import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/forgot_password/sc_forgot_password.dart';
import 'package:totodo/presentation/screen/login/sc_login.dart';
import 'package:totodo/presentation/screen/signup/sc_signup.dart';

class AppRouter {
  static const String kHome = '/';
  static const String kLogin = '/login';
  static const String kSignUp = '/signUp';
  static const String kForgotPassword = '/forgotPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kHome:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case kLogin:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case kSignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case kForgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
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
