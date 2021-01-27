import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class TextFieldDefault extends StatelessWidget {
  final String hindText;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final TextEditingController controller;
  const TextFieldDefault(
      {this.hindText, this.validator, this.controller, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: kColorGray3,
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          style: kFontRegularGray1_12,
          keyboardType: TextInputType.text,
          obscureText: true,
          textAlign: TextAlign.left,
          decoration: InputDecoration.collapsed(
            hintText: hindText,
          ),
        ),
      ),
    );
  }
}
