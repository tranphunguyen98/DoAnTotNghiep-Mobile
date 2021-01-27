import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/presentation/screen/signup/widget_bottom_sign_up.dart';
import 'package:totodo/presentation/screen/signup/widget_sign_up_form.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: ListView(
          children: <Widget>[
            WidgetTopWelcome(),
            WidgetSignUpForm(),
            WidgetBottomSignUp(),
          ],
        ),
      ),
    );
  }
}
