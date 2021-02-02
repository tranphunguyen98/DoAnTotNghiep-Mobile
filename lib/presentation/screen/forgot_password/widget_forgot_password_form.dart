import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/forgotPassword/bloc.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetForgotPasswordForm extends StatefulWidget {
  @override
  _WidgetForgotPasswordFormState createState() =>
      _WidgetForgotPasswordFormState();
}

class _WidgetForgotPasswordFormState extends State<WidgetForgotPasswordForm> {
  ForgotPasswordBloc _forgotPasswordBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering ... '),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Gửi email thành công!'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });
        }

        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${state.error}'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) => Container(
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
                _buildTextFieldPassword(),
                SizedBox(height: 20),
                _buildButtonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isRegisterButtonEnabled() {
    return _forgotPasswordBloc.state.isFormValid &&
        isPopulated &&
        !_forgotPasswordBloc.state.isSubmitting;
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
        text: 'Gửi Email reset mật khẩu',
        isEnable: true,
        onPressed: () {
          if (isRegisterButtonEnabled()) {
            _forgotPasswordBloc.add(ForgotPasswordSubmitEmailPasswordEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ));
          }
        });
  }

  Widget _buildTextFieldEmail() {
    return TextFieldDefault(
      hindText: 'Email',
      controller: _emailController,
      onChanged: (value) {
        _forgotPasswordBloc.add(ForgotEmailChanged(email: value));
      },
      validator: (_) {
        return !_forgotPasswordBloc.state.isEmailValid ? 'Invalid Email' : null;
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFieldDefault(
      hindText: 'Password',
      controller: _passwordController,
      onChanged: (value) {
        _forgotPasswordBloc.add(ForgotPasswordChanged(password: value));
      },
      validator: (_) {
        return !_forgotPasswordBloc.state.isPasswordValid
            ? 'Invalid Password'
            : null;
      },
      obscureText: true,
    );
  }
}
