import 'package:flutter/material.dart';

class TextFieldNonBorder extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function(String value) onFieldSubmitted;
  final TextStyle textStyle;
  final String hint;
  final bool autoFocus;
  final String errorText;
  const TextFieldNonBorder(
      {this.controller,
      this.textStyle,
      this.onChanged,
      this.onFieldSubmitted,
      this.autoFocus = true,
      this.errorText,
      @required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      style: textStyle,
      // focusNode: FocusNode(canRequestFocus: false),
      autofocus: autoFocus,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hint,
        errorText: errorText,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
