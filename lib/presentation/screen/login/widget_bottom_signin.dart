import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../router.dart';

class WidgetBottomSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              'Chưa có mật khẩu?',
              style: kFontRegularWhite_12,
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pushNamed(AppRouter.kSignUp);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Đăng ký',
                  style: kFontRegularWhite_12.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
