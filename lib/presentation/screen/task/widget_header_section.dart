import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/home/dropdown_choice.dart';
import 'package:totodo/presentation/screen/task/widget_bottom_sheet_add_task.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class HeaderSection extends StatelessWidget {
  final String sectionName;
  final String sectionId;
  final TextStyle style;
  final bool expandFlag;
  final VoidCallback onExpand;

  HeaderSection({
    @required this.sectionName,
    @required this.sectionId,
    @required this.style,
    @required this.expandFlag,
    @required this.onExpand,
    Key key,
  }) : super(key: key);

  final List<DropdownChoices> dropdownChoices = [];

  void _intData() {
    dropdownChoices.clear();
    dropdownChoices.addAll([
      DropdownChoices(
          title: 'Thêm Task',
          onPressed: (context) {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)),
              ),
              context: Scaffold.of(context).context,
              builder: (_) => BottomSheetAddTask(
                sectionId: sectionId,
              ),
            );
            //Navigator.pushNamed(context, MyRouter.SETTING);
          }),
      DropdownChoices(title: 'Sửa tên section', onPressed: (context) {}),
      DropdownChoices(title: 'Xóa section', onPressed: (context) {}),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _intData();

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 20.0,
                bottom: 16.0,
              ),
              child: Text(sectionName, style: style
                  // widget.section.listTask.isNotEmpty
                  //     ? kFontSemiboldBlack_16
                  //     : kFontSemiboldGray_16,
                  ),
            ),
            const Spacer(),
            // SizedBox(
            //   width: 36.0,
            //   height: 36.0,
            //   child: ExpandIcon(
            //     isExpanded: expandFlag,
            //     color: kColorBlack2,
            //     expandedColor: kColorBlack2,
            //     disabledColor: kColorBlack2,
            //     onPressed: (bool value) {
            //       // _expand();
            //     },
            //   ),
            // ),
            PopupMenuButton<DropdownChoices>(
              onSelected: (DropdownChoices choice) {
                choice.onPressed(context);
              },
              elevation: 6,
              icon: Icon(
                Icons.more_vert,
                color: kColorBlack2,
              ),
              itemBuilder: (BuildContext context) {
                return dropdownChoices.map((DropdownChoices choice) {
                  return PopupMenuItem<DropdownChoices>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        const Divider(
          thickness: 1.0,
          height: 1.0,
        )
      ],
    );
  }
}