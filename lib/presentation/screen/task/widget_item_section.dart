import 'package:flutter/material.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/presentation/screen/task/widget_list_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class ItemSection extends StatelessWidget {
  final Section section;

  const ItemSection({
    @required this.section,
  });

  bool get isShowSection {
    return section.listTask.isNotEmpty || section.isShowIfEmpty;
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
                        style: section.listTask.isNotEmpty
                            ? kFontSemibold
                            : kFontSemiboldGray,
                      ),
                    ),
                  ],
                ),
              if (section != Section.kSectionNoName &&
                  section.listTask.isNotEmpty)
                Divider(
                  thickness: 1.0,
                ),
              ListTask(section.listTask),
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
            ],
          )
        : Container();
  }
}
