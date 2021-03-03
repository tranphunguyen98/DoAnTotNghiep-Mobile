import 'package:flutter/material.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/presentation/screen/task/widget_list_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemSection extends StatelessWidget {
  final Section section;
  final List<Task> listTask;

  const ItemSection({
    @required this.section,
    @required this.listTask,
  });

  bool get isShowSection {
    return listTask.isNotEmpty || section.isShowIfEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return isShowSection
        ? Column(
            children: [
              if (section != Section.kSectionNoName)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                      child: Text(
                        section.name,
                        style: kFontSemibold,
                      ),
                    ),
                  ],
                ),
              if (section != Section.kSectionNoName)
                Divider(
                  thickness: 1.0,
                ),
              ListTask(listTask),
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
            ],
          )
        : Container();
  }
}
