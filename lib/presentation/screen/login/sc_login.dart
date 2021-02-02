import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/login/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
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
        child: BlocProvider(
          create: (context) =>
              LoginBloc(userRepository: getIt.get<IUserRepository>()),
          child: ListView(
            children: <Widget>[
              WidgetTopWelcome(),
              WidgetLoginForm(),
              WidgetBottomSignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
