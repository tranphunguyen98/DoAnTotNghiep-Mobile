import 'package:flutter/material.dart';
import 'package:totodo/presentation/common_widgets/dropdown_choice.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemPopupMenu extends StatelessWidget {
  final DropdownChoice dropdownChoices;

  const ItemPopupMenu(this.dropdownChoices);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          dropdownChoices.iconData,
          size: 24.0,
          color: dropdownChoices.color ?? kColorGray1,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          dropdownChoices.title,
          style: kFontRegularBlack2_14,
        ),
      ],
    );
  }
}
