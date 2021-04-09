import 'package:flutter/material.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class ContainerInfo extends StatelessWidget {
  final String title;
  final Widget child;

  const ContainerInfo({
    @required this.title,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kFontMediumBlack_14,
          ),
          SizedBox(
            height: 16.0,
          ),
          child,
        ],
      ),
    );
  }
}
