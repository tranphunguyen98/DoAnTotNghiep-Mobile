import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import 'widget_btn_facebook.dart';
import 'widget_btn_google.dart';

class WidgetLoginForm extends StatefulWidget {
  @override
  _WidgetLoginFormState createState() => _WidgetLoginFormState();
}

class _WidgetLoginFormState extends State<WidgetLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kColorWhite,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Đăng nhập tài khoản', style: kFontMediumDefault_16),
            ),
            SizedBox(height: 20),
            _buildTextFieldUsername(),
            SizedBox(height: 14),
            _buildTextFieldPassword(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Quên mật khẩu?',
                style: kFontRegularGray4_12,
              ),
            ),
            SizedBox(height: 20),
            _buildButtonLogin(),
            SizedBox(height: 30),
            _buildTextOr(),
            SizedBox(height: 20),
            _buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          WidgetBtnGoogle(),
          SizedBox(width: 20),
          WidgetBtnFacebook(),
        ],
      ),
    );
  }

  Widget _buildTextOr() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Divider(
            color: kColorBlack_30,
          ),
        ),
        Align(
          child: Container(
            color: kColorWhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Or',
                style: kFontRegularGray5_10,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
      text: 'Đăng Nhập',
      isEnable: true,
      onPressed: () {},
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFieldDefault(
      hindText: 'Mật khẩu',
      controller: _passwordController,
      validator: (_) {
        return null;
      },
      onChanged: (value) {},
    );
  }

  Widget _buildTextFieldUsername() {
    return TextFieldDefault(
      hindText: 'Email',
      controller: _emailController,
      validator: (_) {
        return null;
      },
      onChanged: (value) {},
    );
  }
}
