import 'package:flutter/material.dart';

import '../../../data/entity/check_item.dart';
import '../../../utils/my_const/my_const.dart';
import '../../common_widgets/widget_circle_inkwell.dart';
import '../../common_widgets/widget_text_field_non_border.dart';

class ItemCheckList extends StatelessWidget {
  ItemCheckList({
    Key key,
    @required this.checkItem,
    this.onItemCheckChange,
    this.onItemCheckNameChange,
    this.onDeleteCheckItem,
  }) : super(key: key);

  final CheckItem checkItem;
  final Function(bool value) onItemCheckChange;
  final Function(String value) onItemCheckNameChange;
  final VoidCallback onDeleteCheckItem;

  final _nameCheckListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameCheckListController.text = checkItem.name;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
              value: checkItem.isDone,
              onChanged: onItemCheckChange,
              checkColor: Colors.white,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextFieldNonBorder(
                hint: 'Name CheckList',
                controller: _nameCheckListController,
                autoFocus: false,
                textStyle: checkItem.isDone
                    ? kFontRegularGray1_14
                    : kFontRegularBlack2_14,
                onFieldSubmitted: (value) {
                  if (value.isEmpty) {
                    _nameCheckListController.text = checkItem.name;
                  }
                  onItemCheckNameChange(value);
                }),
          ),
          CircleInkWell(
            Icons.delete,
            sizeIcon: 20.0,
            onPressed: onDeleteCheckItem,
          )
        ],
      ),
    );
  }
}
