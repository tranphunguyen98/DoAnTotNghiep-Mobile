import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/my_const/my_const.dart';

class WidgetBtnGoogle extends StatelessWidget {
  final VoidCallback onPressed;

  const WidgetBtnGoogle({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kColorGoogleBtn,
              border: Border.all(
                width: 0.2,
                color: kColorGoogleBorderBtn,
              )),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/ic_google.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                'Google',
                style: kFontRegularGray4_12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
