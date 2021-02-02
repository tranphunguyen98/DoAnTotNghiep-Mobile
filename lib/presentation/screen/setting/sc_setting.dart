import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/presentation/screen/home/drawer_item_normal.dart';

import '../../router.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cài đặt"),
        ),
        body: Column(
          children: [
            DrawerItemNormal("Change Password", Icons.account_circle, () {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamed(AppRouter.kChangePassword);
              });
            }),
            DrawerItemNormal("Đăng xuất", Icons.logout, () {
              final _authenticationBloc =
                  BlocProvider.of<AuthenticationBloc>(context);
              _authenticationBloc.add(LoggedOut());
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamed(AppRouter.kLogin);
              });
            }),
          ],
        ));
  }
}
