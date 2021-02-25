import 'package:flutter/material.dart';

class DropdownChoice {
  final String title;
  final IconData iconData;
  final Function() onPressed;
  final Color color;

  const DropdownChoice({
    @required @required this.title,
    @required this.onPressed,
    this.iconData,
    this.color,
  });

  static const List<DropdownChoice> dropdownChoicesPriority = [
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.red,
        title: "Priority 1",
        onPressed: null),
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.orange,
        title: "Priority 2",
        onPressed: null),
    DropdownChoice(
        iconData: Icons.flag,
        color: Colors.blue,
        title: "Priority 3",
        onPressed: null),
    DropdownChoice(
        iconData: Icons.flag_outlined, title: "Priority 4", onPressed: null),
  ];
}
