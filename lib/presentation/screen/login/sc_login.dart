import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/login/widget_bottom_signin.dart';
import 'package:totodo/presentation/screen/login/widget_login_form.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: ListView(
          children: <Widget>[
            WidgetTopWelcome(),
            WidgetLoginForm(),
            WidgetBottomSignIn(),
          ],
        ),
      ),
    );
  }
}
