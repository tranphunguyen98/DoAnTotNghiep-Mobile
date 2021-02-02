import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/change_password/bloc.dart';
import 'package:totodo/presentation/common_widgets/widget_flat_button_default.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_default.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetChangePasswordForm extends StatefulWidget {
  @override
  _WidgetChangePasswordFormState createState() =>
      _WidgetChangePasswordFormState();
}

class _WidgetChangePasswordFormState extends State<WidgetChangePasswordForm> {
  ChangePasswordBloc _ChangePasswordBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    _ChangePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Đang thay đổi mật khẩu ... '),
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
                    Text('Thay đổi mật khẩu thành công!'),
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
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
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
                      Text('Thay đổi mật khẩu', style: kFontMediumDefault_16),
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
    return _ChangePasswordBloc.state.isFormValid &&
        isPopulated &&
        !_ChangePasswordBloc.state.isSubmitting;
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
        text: 'Thay đổi mật khẩu',
        isEnable: true,
        onPressed: () {
          if (isRegisterButtonEnabled()) {
            _ChangePasswordBloc.add(ChangePasswordSubmitEmailPasswordEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ));
          }
        });
  }

  Widget _buildTextFieldEmail() {
    return TextFieldDefault(
      hindText: 'Old Password',
      controller: _emailController,
      onChanged: (value) {
        _ChangePasswordBloc.add(ChangeEmailChanged(email: value));
      },
      validator: (_) {
        return !_ChangePasswordBloc.state.isEmailValid
            ? 'Invalid Password'
            : null;
      },
      obscureText: true,
    );
  }

  Widget _buildTextFieldPassword() {
    return TextFieldDefault(
      hindText: 'New Password',
      controller: _passwordController,
      onChanged: (value) {
        _ChangePasswordBloc.add(ChangePasswordChanged(password: value));
      },
      validator: (_) {
        return !_ChangePasswordBloc.state.isPasswordValid
            ? 'Invalid Password'
            : null;
      },
      obscureText: true,
    );
  }
}
