import 'package:flutter/material.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/utils/my_const/font_const.dart';
import 'package:totodo/utils/util.dart';

class ItemLabelCheckBox extends StatelessWidget {
  final Label label;
  final bool isChecked;
  final Function(bool value) onCheckBoxChanged;

  const ItemLabelCheckBox(
      {Key key, this.label, this.isChecked, this.onCheckBoxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.local_offer_outlined,
                color: getColorDefaultFromValue(label.color),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Text(
                label.name,
                style: kFontRegularBlack2,
              ),
              const Spacer(),
              Checkbox(value: isChecked, onChanged: onCheckBoxChanged),
            ],
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
