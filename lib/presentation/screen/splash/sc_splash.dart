import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_logo_totodo.dart';
import 'package:totodo/utils/my_const/color_const.dart';

import '../../router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    openLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: Center(
          child: SizedBox(
            width: 240,
            child: WidgetLogoToToDo(),
          ),
        ),
      ),
    );
  }

  void openLogin() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushNamed(context, AppRouter.kLogin);
    });
  }
}
