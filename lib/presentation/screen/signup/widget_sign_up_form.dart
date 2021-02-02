import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/bloc.dart';
import 'package:totodo/bloc/register/bloc.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetSignUpForm extends StatefulWidget {
  @override
  _WidgetSignUpFormState createState() => _WidgetSignUpFormState();
}

class _WidgetSignUpFormState extends State<WidgetSignUpForm> {
  RegisterBloc _registerBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(() {
      _registerBloc.add(EmailChanged(email: _emailController.text));
    });

    _passwordController.addListener(() {
      _registerBloc.add(PasswordChanged(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ));
    });

    _confirmPasswordController.addListener(() {
      _registerBloc.add(ConfirmPasswordChanged(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
          BlocProvider.of<AuthenticationBloc>(context).add(SignedUp());
          Navigator.of(context).pop();
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
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
                  child:
                      Text('Đăng ký tài khoản', style: kFontMediumDefault_16),
                ),
                SizedBox(height: 20),
                TextFieldDefault(
                  hindText: 'Email',
                  controller: _emailController,
                  validator: (_) {
                    return !state.isEmailValid ? 'Invalid Email' : null;
                  },
                  onChanged: (value) {},
                ),
                SizedBox(height: 14),
                TextFieldDefault(
                  hindText: 'Mật khẩu',
                  controller: _passwordController,
                  validator: (_) {
                    return !state.isPasswordValid ? 'Invalid Password' : null;
                  },
                  onChanged: (value) {},
                  obscureText: true,
                ),
                SizedBox(height: 14),
                TextFieldDefault(
                  hindText: 'Nhập lại mật khẩu',
                  controller: _confirmPasswordController,
                  validator: (_) {
                    return !state.isConfirmPasswordValid
                        ? 'Password does not matched'
                        : null;
                  },
                  onChanged: (value) {},
                  obscureText: true,
                ),
                SizedBox(height: 20),
                _buildButtonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
      text: 'Đăng Ký',
      isEnable: true,
      onPressed: () {
        _onFormSubmitted();
      },
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
