import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ContainerError extends StatelessWidget {
  final String message;
  const ContainerError(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(message, style: kFontRegularGray4_14),
      ),
    );
  }
}
