import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/sc_home.dart';
import 'package:totodo/presentation/screen/login/sc_login.dart';
import 'package:totodo/presentation/screen/splash/sc_splash.dart';
import 'package:totodo/presentation/simple_bloc_delegate.dart';
import 'package:totodo/utils/my_const/color_const.dart';

import '../app_config.dart';
import 'router.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);
    print("build");
    //getIt.get<IUserRepository>().signOut();
    return MaterialApp(
      debugShowCheckedModeBanner: config.debugTag,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kColorPrimary,
        accentColor: kColorPrimary,
        fontFamily: 'Poppins',
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print("state: ${state}");
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Unauthenticated) {
            // Future.delayed(Duration.zero, () {
            //   Navigator.of(context).pushNamed(AppRouter.kLogin);
            // });
            return LoginScreen();
          } else if (state is Authenticated) {
            // Future.delayed(Duration.zero, () {
            //   Navigator.of(context).pushNamed(AppRouter.kHome);
            // });
            return HomeScreen();
          } else {
            return Container(
              child: Center(child: Text('Unhandle State $state')),
            );
          }
        },
      ),
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

    print("runWidget");
    //TODO Repository

    return BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: getIt<IUserRepository>())
            ..add(AppStarted()),
      child: MyApp(),
    );
  }
}
