import 'package:flutter/material.dart';

import '../custom_ui/custom_ui.dart';

class WidgetBtnBack extends StatelessWidget {
  final EdgeInsets padding;

  const WidgetBtnBack(
      {this.padding = const EdgeInsets.only(left: 12, right: 10)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: padding,
        child: CustomSvgImage(
          width: 19,
          height: 16,
          path: 'assets/ic_back.svg',
        ),
      ),
    );
  }
}
