import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetBottomSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              'Đã có tài khoản?',
              style: kFontRegularWhite_12,
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(AppRouter.REGISTER);
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
          ),
        ],
      ),
    );
  }
}
