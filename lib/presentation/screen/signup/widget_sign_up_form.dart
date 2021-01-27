import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetSignUpForm extends StatefulWidget {
  @override
  _WidgetSignUpFormState createState() => _WidgetSignUpFormState();
}

class _WidgetSignUpFormState extends State<WidgetSignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
              child: Text('Đăng ký tài khoản', style: kFontMediumDefault_16),
            ),
            SizedBox(height: 20),
            _buildTextFieldUsername(),
            SizedBox(height: 14),
            _buildTextFieldPassword(),
            SizedBox(height: 14),
            _buildTextFieldConfirmPassword(),
            SizedBox(height: 20),
            _buildButtonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
      text: 'Đăng Ký',
      isEnable: true,
      onPressed: () {},
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

  Widget _buildTextFieldConfirmPassword() {
    return TextFieldDefault(
      hindText: 'Nhập lại mật khẩu',
      controller: _confirmPasswordController,
      validator: (_) {
        return null;
      },
      onChanged: (value) {},
    );
  }
}
