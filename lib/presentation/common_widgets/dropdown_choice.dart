import 'package:flutter/material.dart';

class DropdownChoice {
  final String title;
  final IconData iconData;
  final Color color;

  const DropdownChoice({
    @required this.title,
    @required this.iconData,
    this.color,
  });

  static const List<DropdownChoice> dropdownChoicesPriority = [
    DropdownChoice(
      iconData: Icons.flag,
      color: Colors.red,
      title: "Priority 1",
    ),
    DropdownChoice(
      iconData: Icons.flag,
      color: Colors.orange,
      title: "Priority 2",
    ),
    DropdownChoice(
      iconData: Icons.flag,
      color: Colors.blue,
      title: "Priority 3",
    ),
    DropdownChoice(
      iconData: Icons.flag_outlined,
      title: "Priority 4",
    ),
  ];
}
