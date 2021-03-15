// import 'package:flutter/material.dart';
// import 'package:totodo/data/entity/section.dart';
// import 'package:totodo/presentation/screen/home/dropdown_choice.dart';
// import 'package:totodo/presentation/screen/task/widget_bottom_sheet_add_task.dart';
// import 'package:totodo/presentation/screen/task/widget_list_task.dart';
// import 'package:totodo/utils/my_const/color_const.dart';
// import 'package:totodo/utils/my_const/font_const.dart';
//
// class ItemSection extends StatefulWidget {
//   final Section section;
//
//   const ItemSection({
//     @required this.section,
//   });
//
//   @override
//   _ItemSectionState createState() => _ItemSectionState();
// }
//
// class _ItemSectionState extends State<ItemSection>
//     with SingleTickerProviderStateMixin {
//   bool expandFlag = true;
//   AnimationController _controller;
//
//   final List<DropdownChoices> dropdownChoices = [];
//
//   void _intData() {
//     dropdownChoices.clear();
//     dropdownChoices.addAll([
//       DropdownChoices(
//           title: 'Thêm Task',
//           onPressed: (context) {
//             final future = showModalBottomSheet(
//               isScrollControlled: true,
//               backgroundColor: Colors.white,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(16.0),
//                     topLeft: Radius.circular(16.0)),
//               ),
//               context: Scaffold.of(context).context,
//               builder: (_) => BottomSheetAddTask(
//                 sectionId: widget.section.id,
//               ),
//             );
//             //Navigator.pushNamed(context, MyRouter.SETTING);
//           }),
//       DropdownChoices(title: 'Sửa tên section', onPressed: (context) {}),
//       DropdownChoices(title: 'Xóa section', onPressed: (context) {}),
//     ]);
//   }
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _intData();
//     _controller.forward();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   bool get isShowSection {
//     return widget.section.listTask.isNotEmpty || widget.section.isShowIfEmpty;
//   }
//
//   void _expand() {
//     setState(
//       () {
//         expandFlag = !expandFlag;
//         if (expandFlag) {
//           _controller.forward();
//         } else {
//           _controller.reverse();
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return ListTask(widget.section.listTask);
//     return isShowSection
//         ? InkWell(
//             onTap: _expand,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (widget.section != Section.kSectionNoName)
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 16.0,
//                           right: 16.0,
//                           top: 20.0,
//                           bottom: 16.0,
//                         ),
//                         child: Text(
//                           widget.section.name,
//                           style: widget.section.listTask.isNotEmpty
//                               ? kFontSemiboldBlack_16
//                               : kFontSemiboldGray_16,
//                         ),
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         width: 36.0,
//                         height: 36.0,
//                         child: ExpandIcon(
//                           isExpanded: expandFlag,
//                           color: kColorBlack2,
//                           expandedColor: kColorBlack2,
//                           disabledColor: kColorBlack2,
//                           onPressed: (bool value) {
//                             _expand();
//                           },
//                         ),
//                       ),
//                       PopupMenuButton<DropdownChoices>(
//                         onSelected: (DropdownChoices choice) {
//                           choice.onPressed(context);
//                         },
//                         elevation: 6,
//                         icon: Icon(
//                           Icons.more_vert,
//                           color: kColorBlack2,
//                         ),
//                         itemBuilder: (BuildContext context) {
//                           return dropdownChoices.map((DropdownChoices choice) {
//                             return PopupMenuItem<DropdownChoices>(
//                               value: choice,
//                               child: Text(choice.title),
//                             );
//                           }).toList();
//                         },
//                       ),
//                     ],
//                   ),
//                 if (widget.section != Section.kSectionNoName &&
//                     widget.section.listTask.isNotEmpty)
//                   const Divider(
//                     thickness: 1.0,
//                     height: 1,
//                   ),
//                 SizeTransition(
//                   sizeFactor: _controller,
//                   child: ListTask(widget.section.listTask),
//                 ),
//                 //Expanded(child: ListTask(widget.section.listTask)),
//                 if (expandFlag)
//                   const Divider(
//                     thickness: 1.0,
//                     height: 1.0,
//                   ),
//               ],
//             ),
//           )
//         : Container();
//   }
// }
