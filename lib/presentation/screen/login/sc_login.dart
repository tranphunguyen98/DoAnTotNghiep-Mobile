import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/data/repository_interface/i_user_repository.dart';

import '../../../bloc/login/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/color_const.dart';
import 'widget_bottom_signin.dart';
import 'widget_login_form.dart';
import 'widget_top_welcome.dart';

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
