import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetForgotPasswordForm extends StatefulWidget {
  @override
  _WidgetForgotPasswordFormState createState() =>
      _WidgetForgotPasswordFormState();
}

class _WidgetForgotPasswordFormState extends State<WidgetForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();

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
              child: Text('Quên mật khẩu', style: kFontMediumDefault_16),
            ),
            SizedBox(height: 20),
            _buildTextFieldEmail(),
            SizedBox(height: 20),
            _buildButtonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
      text: 'Gửi Email quên mật khẩu',
      isEnable: true,
      onPressed: () {},
    );
  }

  Widget _buildTextFieldEmail() {
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
