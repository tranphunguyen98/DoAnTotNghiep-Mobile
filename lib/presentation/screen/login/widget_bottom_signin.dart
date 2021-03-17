import 'package:flutter/material.dart';

import '../../../utils/my_const/my_const.dart';
import '../../router.dart';

class WidgetBottomSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Chưa có mật khẩu?',
            style: kFontRegularWhite_12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.kSignUp);
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
        ],
      ),
    );
  }
}
