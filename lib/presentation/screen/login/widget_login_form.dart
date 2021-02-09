import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/bloc/login/bloc.dart';
import 'package:totodo/presentation/common_widgets/custom_snackbar.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../router.dart';
import 'widget_btn_facebook.dart';
import 'widget_btn_google.dart';

class WidgetLoginForm extends StatefulWidget {
  @override
  _WidgetLoginFormState createState() => _WidgetLoginFormState();
}

class _WidgetLoginFormState extends State<WidgetLoginForm> {
  AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          _authenticationBloc.add(LoggedIn());
        }

        if (state.isFailure) {
          CustomSnackBar.failure(context, msg: state.error);
        }

        if (state.isSubmitting) {
          CustomSnackBar.showLoading(context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
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
                    child: Text('Đăng nhập tài khoản',
                        style: kFontMediumDefault_16),
                  ),
                  SizedBox(height: 20),
                  _buildTextFieldEmail(),
                  SizedBox(height: 14),
                  _buildTextFieldPassword(),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.kForgotPassword);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Quên mật khẩu?',
                        style: kFontRegularGray4_12,
                      ),
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
        },
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          WidgetBtnGoogle(
            onPressed: () async {
              _loginBloc.add(LoginWithGoogleEvent());
            },
          ),
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

  bool isRegisterButtonEnabled() {
    return _loginBloc.state.isFormValid &&
        isPopulated &&
        !_loginBloc.state.isSubmitting;
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
      text: 'Đăng Nhập',
      isEnable: true,
      onPressed: () {
        if (isRegisterButtonEnabled()) {
          _loginBloc.add(LoginSubmitEmailPasswordEvent(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        }
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFieldDefault(
      hindText: 'Mật khẩu',
      controller: _passwordController,
      onChanged: (value) {
        _loginBloc.add(LoginPasswordChanged(password: value));
      },
      validator: (_) {
        return !_loginBloc.state.isPasswordValid ? 'Invalid Password' : null;
      },
      obscureText: true,
    );
  }

  Widget _buildTextFieldEmail() {
    return TextFieldDefault(
      hindText: 'Email',
      controller: _emailController,
      onChanged: (value) {
        _loginBloc.add(LoginEmailChanged(email: value));
      },
      validator: (_) {
        return !_loginBloc.state.isEmailValid ? 'Invalid Email' : null;
      },
    );
  }
}
