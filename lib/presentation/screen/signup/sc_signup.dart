import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/repository_interface/i_user_repository.dart';
import '../../../bloc/signup/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/color_const.dart';
import '../login/widget_top_welcome.dart';
import 'widget_bottom_sign_up.dart';
import 'widget_sign_up_form.dart';

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
