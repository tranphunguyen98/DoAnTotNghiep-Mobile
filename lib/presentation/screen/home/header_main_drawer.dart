import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/presentation/router.dart';

import '../../../bloc/auth_bloc/authentication_bloc.dart';
import '../../../bloc/auth_bloc/authentication_state.dart';
import '../../../utils/my_const/my_const.dart';
import '../../common_widgets/widget_circle_avatar_network.dart';

class HeaderMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.kProfile);
            },
            child: SizedBox(
              height: 120.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kColorPrimary,
                ),
                child: Row(
                  children: [
                    CircleAvatarNetwork(
                      size: 40,
                      imageUrl: user.avatar,
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: kFontMediumWhite_14,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          user?.email ?? 'email',
                          style: kFontRegularWhite_12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
