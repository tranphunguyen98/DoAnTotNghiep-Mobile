import 'package:flutter/material.dart';
import 'package:totodo/presentation/screen/home/dropdown_choice.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class PopupMenuHabitDetail extends StatelessWidget {
  final Function onDeleteHabit;
  final Function onEditHabit;
  final Function onArchiveHabit;

  PopupMenuHabitDetail(
      {this.onDeleteHabit, this.onArchiveHabit, this.onEditHabit});

  final List<DropdownChoices> dropdownChoices = [];

  @override
  Widget build(BuildContext context) {
    dropdownChoices.clear();
    dropdownChoices.addAll(getDropdownChoices());
    return PopupMenuButton<DropdownChoices>(
      onSelected: (DropdownChoices choice) {
        choice.onPressed(context);
      },
      elevation: 6,
      icon: Icon(
        Icons.more_vert,
        color: kColorWhite,
      ),
      itemBuilder: (BuildContext context) {
        return dropdownChoices.map((DropdownChoices choice) {
          return PopupMenuItem<DropdownChoices>(
            value: choice,
            child: Text(choice.title),
          );
        }).toList();
      },
    );
  }

  List<DropdownChoices> getDropdownChoices() {
    final listDropdownChoices = [
      DropdownChoices(
          title: 'Sửa',
          onPressed: (context) {
            onEditHabit();
          }),
      DropdownChoices(
          title: 'Hoàn thành',
          onPressed: (context) {
            onArchiveHabit();
          }),
      DropdownChoices(
          title: 'Xóa',
          onPressed: (context) {
            onDeleteHabit();
          })
    ];
    return listDropdownChoices;
  }
}