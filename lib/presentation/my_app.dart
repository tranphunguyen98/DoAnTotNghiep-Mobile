import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/simple_bloc_delegate.dart';
import 'package:totodo/utils/my_const/color_const.dart';

import '../app_config.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

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

    return BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: getIt<IUserRepository>())
            ..add(AppStarted()),
      child: MyApp(),
    );
  }
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);
    print("build MyApp");
    //getIt.get<IUserRepository>().signOut();
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: config.debugTag,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kColorPrimary,
        accentColor: kColorPrimary,
        fontFamily: 'Poppins',
      ),
      initialRoute: config.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Uninitialized) {
              print("Uninitialized");
              _navigator.pushNamedAndRemoveUntil(
                  AppRouter.kSplash, (_) => false);
            } else if (state is Unauthenticated) {
              print("Unauthenticated");
              _navigator.pushNamedAndRemoveUntil(
                  AppRouter.kLogin, (_) => false);
            } else if (state is Authenticated) {
              print("Authenticated 111");
              _navigator.pushNamedAndRemoveUntil(AppRouter.kHome, (_) => false);
            }
          },
          child: child,
        );
      },
      // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state) {
      //     print("state: ${state}");
      //     if (state is Uninitialized) {
      //       return LoginScreen();
      //     } else if (state is Unauthenticated) {
      //       // Future.delayed(Duration.zero, () {
      //       //   Navigator.of(context).pushNamed(AppRouter.kLogin);
      //       // });
      //       return LoginScreen();
      //     } else if (state is Authenticated) {
      //       // Future.delayed(Duration.zero, () {
      //       //   Navigator.of(context).pushNamed(AppRouter.kHome);
      //       // });
      //       print("Authenticated");
      //       return HomeScreen();
      //     } else {
      //       return Container(
      //         child: Center(child: Text('Unhandle State $state')),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
