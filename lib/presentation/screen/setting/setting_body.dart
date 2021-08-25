import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/data/model/user.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/drawer_item_normal.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Column(
      children: [
        if ((_authenticationBloc.state as Authenticated).user.type ==
            User.kTypeEmail)
          DrawerItemNormal("Thay đổi mật khẩu", Icons.account_circle, () {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushNamed(AppRouter.kChangePassword);
            });
          }),
        DrawerItemNormal("Đăng xuất", Icons.logout, () {
          _authenticationBloc.add(LoggedOut());
          getIt<ITaskRepository>().clearDataOffline();
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushNamed(AppRouter.kLogin);
          });
        }),
      ],
    );
  }
}