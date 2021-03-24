import 'package:flutter/material.dart';

class ItemDataStatisticProject {
  final String nameProject;
  final int totalTask;
  final int completedTask;
  final Color projectColor;

  const ItemDataStatisticProject({
    @required this.nameProject,
    @required this.totalTask,
    @required this.projectColor,
    @required this.completedTask,
  });
}
