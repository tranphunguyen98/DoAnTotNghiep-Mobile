import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class EmptyTask extends StatelessWidget {
  final String message;

  const EmptyTask([this.message = "Danh sách Task rỗng!"]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/empty.svg',
            height: 200,
          ),
          const SizedBox(
            height: 32.0,
          ),
          Text(
            message,
            style: kFontRegularGray4_14,
          )
        ],
      ),
    );
  }
}
