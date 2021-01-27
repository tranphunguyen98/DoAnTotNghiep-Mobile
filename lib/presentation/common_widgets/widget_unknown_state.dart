import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class WidgetUnknownState extends StatelessWidget {
  const WidgetUnknownState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text('Unknown state', style: kFontRegularGray4_14),
      ),
    );
  }
}
