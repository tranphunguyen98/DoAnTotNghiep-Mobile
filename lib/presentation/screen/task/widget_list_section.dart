import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/submit_task/task_submit_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_header_section.dart';
import 'package:totodo/presentation/screen/task/widget_item_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';

import '../../router.dart';

class ListSection extends StatelessWidget {
  final List<Section> listSection;
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  ListSection(this.listSection);

  String getIdSectionBellow(
      int newIndex, int oldIndex, List<Widget> listWidgetSection) {
    final smallerIndex = newIndex < oldIndex ? newIndex : oldIndex;
    final biggerIndex = newIndex > oldIndex ? newIndex : oldIndex;
    for (int i = biggerIndex; i >= smallerIndex; i--) {
      // print("i:$i : ${listWidgetSection[i] is HeaderSection}");
      if (listWidgetSection[i] is HeaderSection) {
        // print("key: ${(listWidgetSection[i] as HeaderSection).sectionId}");
        // print("name: ${(listWidgetSection[i] as HeaderSection).sectionName}");
        // if (listWidgetSection[oldIndex] is ItemTask) {
        //   print("task: ${(listWidgetSection[oldIndex] as ItemTask).task.name}");
        // } else {
        //   print(
        //       "section: ${(listWidgetSection[oldIndex] as HeaderSection).sectionName}");
        // }
        return (listWidgetSection[i] as HeaderSection).sectionId;
      }
    }
    return null;
  }

  String getIdSectionAbove(
      int newIndex, int oldIndex, List<Widget> listWidgetSection) {
    final smallerIndex = newIndex < oldIndex ? newIndex : oldIndex;
    for (var i = smallerIndex - 1; i >= 0; i--) {
      if (listWidgetSection[i] is HeaderSection) {
        return (listWidgetSection[i] as HeaderSection).sectionId;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final listWidgetSection = getListWidgetSection(context);
    return BlocListener<TaskSubmitBloc, TaskSubmitState>(
        cubit: _taskSubmitBloc,
        listener: (context, state) {
          if (state.success) {
            getIt<TaskBloc>().add(DataListTaskChanged());
            _taskSubmitBloc.add(HandledSuccessState());
          }
        },
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {

            // These two lines are workarounds for ReorderableListView problems
            if (newIndex > listWidgetSection.length) {
              newIndex = listWidgetSection.length;
            }
            if (oldIndex < newIndex) newIndex--;

            final idSectionBelow =
                getIdSectionBellow(newIndex, oldIndex, listWidgetSection);
            final idSectionAbove =
                getIdSectionAbove(newIndex, oldIndex, listWidgetSection);


            if (idSectionBelow != null) {
              if (oldIndex > newIndex) {
                _taskSubmitBloc.add(
                  SubmitEditTask(
                    (listWidgetSection[oldIndex] as ItemTask).task.copyWith(
                          sectionId: idSectionAbove ?? '',
                        ),
                  ),
                );
              } else {
                _taskSubmitBloc.add(
                  SubmitEditTask(
                    (listWidgetSection[oldIndex] as ItemTask).task.copyWith(
                          sectionId: idSectionBelow,
                        ),
                  ),
                );
              }
            }
          },
          children: listWidgetSection,
        )
        //     ListView.builder(
        //   padding: EdgeInsets.symmetric(vertical: 16.0),
        //   itemBuilder: (context, index) {
        //     return ItemSection(
        //       section: listSection[index],
        //     );
        //   },
        //   itemCount: listSection.length,
        //   physics: BouncingScrollPhysics(),
        // ),
        );
  }

  List<Widget> getListWidgetSection(BuildContext context) {
    final listWidget = <Widget>[];

    for (final section in listSection) {
      if (section != Section.kSectionNoName) {
        listWidget.add(
          HeaderSection(
            key: ValueKey(section.id),
            sectionName: section.name,
            sectionId: section.id,
            style: kFontSemiboldBlack,
            expandFlag: true,
            onExpand: () {},
          ),
        );
      }
      for (final task in section.listTask) {
        listWidget.add(ItemTask(
          key: ValueKey(task.id),
          task: task,
          updateTask: (task) {
            _taskSubmitBloc.add(SubmitEditTask(task));
          },
          onPressed: (Task task) {
            Navigator.of(context)
                .pushNamed(AppRouter.kDetailTask, arguments: task);
          },
        ));
      }
    }
    return listWidget;
  }
}
