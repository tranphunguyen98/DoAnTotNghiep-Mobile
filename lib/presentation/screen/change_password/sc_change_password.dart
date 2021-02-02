import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/change_password/bloc.dart';
import 'package:totodo/bloc/repository_interface/i_user_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/change_password/widget_change_password_form.dart';
import 'package:totodo/presentation/screen/login/widget_top_welcome.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ChangePasswordBloc>(
        create: (BuildContext context) =>
            ChangePasswordBloc(userRepository: getIt<IUserRepository>()),
        child: Container(
          color: kColorPrimary,
          child: ListView(
            children: <Widget>[
              WidgetTopWelcome(),
              WidgetChangePasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
