import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class TextFieldDefault extends StatefulWidget {
  final String hindText;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final bool isObscure;

  const TextFieldDefault({
    this.hindText,
    this.validator,
    this.controller,
    this.onChanged,
    this.textInputAction,
    this.isObscure = false,
  });

  @override
  _TextFieldDefaultState createState() => _TextFieldDefaultState();
}

class _TextFieldDefaultState extends State<TextFieldDefault> {
  bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.validator('') != null ? 60 : 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kColorGray3,
      ),
      child: Center(
        child: TextFormField(
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          onChanged: widget.onChanged,
          style: kFontRegularGray1_12,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.always,
          obscureText: _isObscure,
          textAlign: TextAlign.left,
          validator: widget.validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hindText,
            // isDense: true,
            contentPadding: const EdgeInsets.only(top: 4.0),
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.isObscure
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility,
                            size: 20,
                          ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
