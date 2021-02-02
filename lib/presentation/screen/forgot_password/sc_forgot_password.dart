import 'package:flutter/material.dart';
import 'package:totodo/bloc/forgotPassword/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/forgot_password/widget_forgot_password_form.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ForgotPasswordBloc>(
        create: (BuildContext context) =>
            ForgotPasswordBloc(userRepository: getIt<IUserRepository>()),
        child: Container(
          color: kColorPrimary,
          child: ListView(
            children: <Widget>[
              WidgetTopWelcome(),
              WidgetForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
