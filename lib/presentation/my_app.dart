import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/presentation/screen/forgot_password/sc_forgot_password.dart';
import 'package:totodo/presentation/simple_bloc_delegate.dart';
import 'package:totodo/utils/my_const/color_const.dart';

import '../app_config.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: config.debugTag,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kColorPrimary,
        accentColor: kColorPrimary,
        fontFamily: 'Poppins',
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: ForgotPasswordScreen(),
    );
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kColorStatusBar,
      ),
    );
  }

  static Widget runWidget() {
    WidgetsFlutterBinding.ensureInitialized();

    BlocSupervisor.delegate = SimpleBlocDelegate();

    //TODO Repository

    return MyApp();
  }
}
