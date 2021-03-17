import 'package:flutter/material.dart';

import '../../../utils/my_const/font_const.dart';
import '../../common_widgets/widget_logo_totodo.dart';

class WidgetTopWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        SizedBox(
          width: 100,
          child: WidgetLogoToToDo(),
        ),
        const SizedBox(height: 16),
        Text('Xin chào bạn', style: kFontMediumWhite_22),
        Text('Đăng nhập để theo dõi kế hoạch của bạn',
            style: kFontMediumWhite_14),
        const SizedBox(height: 30),
      ],
    );
  }
}
