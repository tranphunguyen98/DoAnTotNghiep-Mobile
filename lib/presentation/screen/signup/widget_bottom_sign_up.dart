import 'package:flutter/material.dart';

import '../../../utils/my_const/my_const.dart';
import '../../router.dart';

class WidgetBottomSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Đã có tài khoản?',
            style: kFontRegularWhite_12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.kLogin);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'Đăng nhập',
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
