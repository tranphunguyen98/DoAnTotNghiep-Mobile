import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class WidgetBtnFacebook extends StatelessWidget {
  final VoidCallback onPressed;

  const WidgetBtnFacebook({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kColorFacebookBtn,
              border: Border.all(
                width: 0.2,
                color: kColorFacebookBorderBtn,
              )),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/ic_facebook.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                'Facebook',
                style: kFontRegularGray4_12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
