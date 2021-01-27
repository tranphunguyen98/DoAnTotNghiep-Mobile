import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/forgot_password/widget_forgot_password_form.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: ListView(
          children: <Widget>[
            WidgetTopWelcome(),
            WidgetForgotPasswordForm(),
          ],
        ),
      ),
    );
  }
}
