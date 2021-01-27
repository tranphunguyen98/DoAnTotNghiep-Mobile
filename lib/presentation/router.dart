import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/login/sc_login.dart';

class AppRouter {
  static const String HOME = '/';
  static const String LOGIN = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
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
