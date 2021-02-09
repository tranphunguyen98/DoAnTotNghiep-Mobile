import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_logo_totodo.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
}
