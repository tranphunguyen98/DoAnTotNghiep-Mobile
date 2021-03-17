import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/auth_bloc/authentication_bloc.dart';
import 'package:totodo/bloc/auth_bloc/authentication_state.dart';
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
  ChangePasswordBloc _changePasswordBloc;
  AuthenticationBloc _authenticationBloc;

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  bool get isPopulated =>
      _oldPassword.text.isNotEmpty && _newPassword.text.isNotEmpty;

  @override
  void initState() {
    _changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
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
                    const Text('Đang thay đổi mật khẩu ... '),
                    const CircularProgressIndicator(),
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
                    const Text('Thay đổi mật khẩu thành công!'),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          Future.delayed(const Duration(milliseconds: 1000), () {
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
                    Text(state.error),
                    const Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                const SizedBox(height: 20),
                _buildTextFieldOldPassword(),
                const SizedBox(height: 20),
                _buildTextFieldNewPassword(),
                const SizedBox(height: 20),
                _buildButtonLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isRegisterButtonEnabled() {
    return _changePasswordBloc.state.isFormValid &&
        isPopulated &&
        !_changePasswordBloc.state.isSubmitting;
  }

  Widget _buildButtonLogin() {
    return FlatButtonDefault(
        text: 'Thay đổi mật khẩu',
        isEnable: true,
        onPressed: () {
          if (isRegisterButtonEnabled()) {
            _changePasswordBloc.add(ChangePasswordSubmitEmailPasswordEvent(
              authorization: (_authenticationBloc.state as Authenticated)
                  .user
                  .authorization,
              oldPassword: _oldPassword.text,
              newPassword: _newPassword.text,
            ));
          }
        });
  }

  Widget _buildTextFieldOldPassword() {
    return TextFieldDefault(
      hindText: 'Old Password',
      controller: _oldPassword,
      onChanged: (value) {
        _changePasswordBloc.add(ChangeOldPassword(oldPassword: value));
      },
      validator: (_) {
        return !_changePasswordBloc.state.isOldPasswordValid
            ? 'Invalid Password'
            : null;
      },
      isObscure: true,
    );
  }

  Widget _buildTextFieldNewPassword() {
    return TextFieldDefault(
      hindText: 'New Password',
      controller: _newPassword,
      onChanged: (value) {
        _changePasswordBloc.add(ChangePasswordChanged(password: value));
      },
      validator: (_) {
        return !_changePasswordBloc.state.isNewPasswordValid
            ? 'Invalid Password'
            : null;
      },
      isObscure: true,
    );
  }
}
