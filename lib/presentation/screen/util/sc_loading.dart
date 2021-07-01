import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/widget_logo_totodo.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kColorPrimary,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 240,
                child: WidgetLogoToToDo(),
              ),
              SizedBox(
                height: 24,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Đang tải dữ liệu, vui lòng chờ...',
                style: kFontSemiboldWhite_16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
