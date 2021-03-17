import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/presentation/common_widgets/barrel_common_widgets.dart';
import 'package:totodo/utils/util.dart';

import '../../../bloc/auth_bloc/bloc.dart';
import '../../../bloc/signup/bloc.dart';
import '../../../utils/my_const/my_const.dart';
import '../../common_widgets/widget_flat_button_default.dart';
import '../../common_widgets/widget_text_field_default.dart';

class WidgetSignUpForm extends StatefulWidget {
  @override
  _WidgetSignUpFormState createState() => _WidgetSignUpFormState();
}

class _WidgetSignUpFormState extends State<WidgetSignUpForm> {
  final String kIdDebounce = 'debounce';
  RegisterBloc _registerBloc;

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get isPopulated =>
      _displayNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          SnackBarHelper.showLoading(context, msg: 'Đang đăng ký...');
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(SignedUp());
          Navigator.of(context).pop();
        }

        if (state.isFailure) {
          SnackBarHelper.failure(context, msg: 'Đăng ký thất bại!');
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
                      Text('Đăng ký tài khoản', style: kFontMediumDefault_16),
                ),
                const SizedBox(height: 20),
                TextFieldDefault(
                    hindText: 'Tên đăng nhập',
                    controller: _displayNameController,
                    textInputAction: TextInputAction.next,
                    validator: (_) {
                      return !state.isDisplayNameValid
                          ? 'Tên đăng nhập không hợp lệ!'
                          : null;
                    },
                    onChanged: _onDisplayNameChange),
                const SizedBox(
                  height: 14,
                ),
                TextFieldDefault(
                  hindText: 'Email',
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  validator: (_) {
                    return !state.isEmailValid ? 'Email không hợp lệ!' : null;
                  },
                  onChanged: _onEmailChange,
                ),
                const SizedBox(height: 14),
                TextFieldDefault(
                  hindText: 'Mật khẩu',
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Mật khẩu không hợp lệ!'
                        : null;
                  },
                  onChanged: _onPasswordChange,
                  isObscure: true,
                ),
                const SizedBox(height: 14),
                TextFieldDefault(
                  hindText: 'Nhập lại mật khẩu',
                  isObscure: true,
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  validator: (_) {
                    return !state.isConfirmPasswordValid
                        ? 'Mật khẩu không khớp!'
                        : null;
                  },
                  onChanged: _onConfirmPasswordChange,
                ),
                const SizedBox(height: 20),
                FlatButtonDefault(
                  text: 'Đăng Ký',
                  isEnable: isRegisterButtonEnabled(),
                  onPressed: isRegisterButtonEnabled()
                      ? () {
                          dismissKeyboard(context);
                          _onFormSubmitted();
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isRegisterButtonEnabled() {
    return _registerBloc.state.isFormValid &&
        isPopulated &&
        !_registerBloc.state.isSubmitting;
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        displayName: _displayNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }

  void _onDisplayNameChange(String value) {
    EasyDebounce.debounce(
      kIdDebounce,
      const Duration(milliseconds: 300),
      () => _registerBloc.add(
        DisplayNameChanged(displayName: _displayNameController.text),
      ),
    );
  }

  void _onEmailChange(String value) {
    EasyDebounce.debounce(
      kIdDebounce,
      const Duration(milliseconds: 300),
      () => _registerBloc.add(
        EmailChanged(email: _emailController.text),
      ),
    );
  }

  void _onPasswordChange(String value) {
    EasyDebounce.debounce(
      kIdDebounce,
      const Duration(milliseconds: 300),
      () => _registerBloc.add(
        PasswordChanged(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      ),
    );
  }

  void _onConfirmPasswordChange(String value) {
    EasyDebounce.debounce(
      kIdDebounce,
      const Duration(milliseconds: 300),
      () => _registerBloc.add(
        ConfirmPasswordChanged(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    EasyDebounce.cancel(kIdDebounce);
    _registerBloc.close();
    super.dispose();
  }
}
