import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:hive/hive.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/simple_bloc_delegate.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/notification_helper.dart';

import '../app_config.dart';
import 'router.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kColorStatusBar,
      ),
    );
  }

  static Widget runWidget() {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = SimpleBlocDelegate();

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
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        requestUserPermission();
      }
    });

    super.initState();
  }

  Future<void> requestUserPermission() async {
    showDialog(
      context: context,
      builder: (_) => NetworkGiffyDialog(
        buttonOkText:
            const Text('Allow', style: TextStyle(color: Colors.white)),
        buttonCancelText:
            const Text('Later', style: TextStyle(color: Colors.white)),
        buttonOkColor: Colors.deepPurple,
        buttonRadius: 0.0,
        image:
            Image.asset("assets/images/animated-bell.gif", fit: BoxFit.cover),
        title: const Text('Gửi thông báo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        description: const Text(
          'Cho phép gửi thông báo!',
          textAlign: TextAlign.center,
        ),
        onCancelButtonPressed: () async {
          Navigator.of(context).pop();
        },
        onOkButtonPressed: () async {
          Navigator.of(context).pop();
          await AwesomeNotifications().requestPermissionToSendNotifications();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);
    // print("build MyApp");
    //getIt.get<IUserRepository>().signOut();
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: config.debugTag,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kColorPrimary,
        accentColor: kColorPrimary,
        primaryTextTheme:
            const TextTheme(headline6: TextStyle(color: Colors.white)),
        fontFamily: 'Poppins',
      ),
      initialRoute: config.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Uninitialized) {
              _navigator.pushNamedAndRemoveUntil(
                  AppRouter.kSplash, (_) => false);
            } else if (state is Unauthenticated) {
              _navigator.pushNamedAndRemoveUntil(
                  AppRouter.kLogin, (_) => false);
            } else if (state is Authenticated) {
              AwesomeNotifications()
                  .actionStream
                  .listen((receivedNotification) async {
                await _navigatorKey.currentState.pushNamed(
                  AppRouter.kDetailTask,
                  arguments: receivedNotification
                      .payload[kKeyPayloadNotificationIdTask] as String,
                );
              });
              _navigator.pushNamedAndRemoveUntil(AppRouter.kHome, (_) => false);
            }
          },
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
