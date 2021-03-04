import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropdownChoices {
  const DropdownChoices({
    @required this.title,
    @required this.onPressed,
  });

  final String title;
  final Function(BuildContext context) onPressed;
}
