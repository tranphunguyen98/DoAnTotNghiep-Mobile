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
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _otpController.text.isNotEmpty;

  @override
  void initState() {
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        print("state: $state");
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Reseting ... '),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isResetPasswordSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Reset mật khẩu thành công'),
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
        builder: (context, state) {
          print("stateee: $state");
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
                    child: Text('Reset Mật Khẩu', style: kFontMediumDefault_16),
                  ),
                  SizedBox(height: 20),
                  _buildTextFieldEmail(),
                  if (state.isSendOTPSuccess)
                    Column(
                      children: [
                        SizedBox(height: 20),
                        _buildTextFieldOtpCode(),
                        SizedBox(height: 20),
                        _buildTextFieldPassword(),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              _forgotPasswordBloc.add(SendOTPSubmitEvent(
                                  email: _emailController.text));
                            },
                            child: Text("Gửi lại mã OTP"))
                      ],
                    ),
                  SizedBox(height: 20),
                  _buildButtonSubmit(state.isSendOTPSuccess),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isButtonEnabled(bool isSendOTPSuccess) {
    if (!isSendOTPSuccess) {
      print("abc");
      return _forgotPasswordBloc.state.isEmailValid &&
          _emailController.text.isNotEmpty &&
          !_forgotPasswordBloc.state.isSubmitting;
    } else {
      return _forgotPasswordBloc.state.isFormValid &&
          isPopulated &&
          !_forgotPasswordBloc.state.isSubmitting;
    }
  }

  Widget _buildButtonSubmit(bool isSendOTPSuccess) {
    return FlatButtonDefault(
        text: isSendOTPSuccess ? 'Reset mật khẩu' : 'Gửi OTP tới Email',
        onPressed: isButtonEnabled(isSendOTPSuccess)
            ? () {
                if (isButtonEnabled(isSendOTPSuccess)) {
                  if (isSendOTPSuccess) {
                    _forgotPasswordBloc
                        .add(ForgotPasswordSubmitEmailPasswordEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                      otpCode: _otpController.text,
                    ));
                  } else {
                    _forgotPasswordBloc.add(SendOTPSubmitEvent(
                      email: _emailController.text,
                    ));
                  }
                }
              }
            : null);
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

  Widget _buildTextFieldOtpCode() {
    return TextFieldDefault(
      hindText: 'OTP Code',
      controller: _otpController,
      onChanged: (value) {
        _forgotPasswordBloc.add(ForgotOTPCodeChanged(otpCode: value));
      },
      validator: (_) {
        return !_forgotPasswordBloc.state.isOTPValid
            ? 'OTP Code không hợp lệ'
            : null;
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFieldDefault(
      hindText: 'New Password',
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
