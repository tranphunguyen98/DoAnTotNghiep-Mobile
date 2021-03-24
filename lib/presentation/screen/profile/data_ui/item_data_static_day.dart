import 'package:flutter/foundation.dart';

class ItemDataStatisticDay {
  final int completedTask;
  final int allTask;
  final String title;

  const ItemDataStatisticDay({
    @required this.completedTask,
    @required this.allTask,
    @required this.title,
  });
}
