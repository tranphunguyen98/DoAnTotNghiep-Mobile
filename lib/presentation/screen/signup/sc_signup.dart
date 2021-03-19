import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/bloc/signup/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/presentation/screen/signup/widget_bottom_sign_up.dart';
import 'package:totodo/presentation/screen/signup/widget_sign_up_form.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        create: (BuildContext context) =>
            RegisterBloc(userRepository: getIt<IUserRepository>()),
        child: Container(
          color: kColorPrimary,
          child: ListView(
            children: <Widget>[
              WidgetTopWelcome(),
              WidgetSignUpForm(),
              WidgetBottomSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
