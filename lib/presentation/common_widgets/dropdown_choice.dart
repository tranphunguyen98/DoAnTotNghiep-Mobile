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
}
