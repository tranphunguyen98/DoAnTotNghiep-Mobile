import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/profile/bloc.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_avatar_network.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class HeaderProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.user != null) {
          return Container(
            height: 72,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatarNetwork(imageUrl: state.user.avatar, size: 40.0),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.user.name,
                      style: kFontMediumBlack_14,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Bạn đã hoàn thành 120 Task',
                      style: kFontMediumBlack_14.copyWith(color: kColorPrimary),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
