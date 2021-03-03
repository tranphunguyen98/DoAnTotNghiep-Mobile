import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/data/entity/user.dart';
import 'package:totodo/presentation/screen/home/drawer_item_normal.dart';

import '../../router.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Cài đặt"),
        ),
        body: Column(
          children: [
            if ((_authenticationBloc.state as Authenticated).user.type ==
                User.kTypeEmail)
              DrawerItemNormal("Change Password", Icons.account_circle, () {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushNamed(AppRouter.kChangePassword);
                });
              }),
            DrawerItemNormal("Đăng xuất", Icons.logout, () {
              _authenticationBloc.add(LoggedOut());
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamed(AppRouter.kLogin);
              });
            }),
          ],
        ));
  }
}
