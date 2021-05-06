import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_container_error.dart';
import 'package:totodo/presentation/screen/task/widget_empty_task.dart';
import 'package:totodo/presentation/screen/task/widget_header_section.dart';
import 'package:totodo/presentation/screen/task/widget_item_task.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../router.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final HomeBloc _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.msg != null) {
          return ContainerError(state.msg);
        }

        if (state.listSectionDataDisplay() != null) {
          if (state.listSectionDataDisplay().isEmpty) {
            return const EmptyTask();
          } else {
            final listWidgetSection =
                getListWidgetSection(state.listSectionDataDisplay());
            return ReorderableListView.builder(
              itemBuilder: (context, index) => listWidgetSection[index],
              itemCount: listWidgetSection.length,
              onReorder: (oldIndex, newIndex) {
                _onReorder(oldIndex, newIndex, listWidgetSection);
              },
            );
          }
        }

        return Container();
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex, List<Widget> listWidgetSection) {
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
        _homeBloc.add(
          UpdateTaskEvent(
            (listWidgetSection[oldIndex] as ItemTask).task.copyWith(
                  sectionId: idSectionAbove ?? '',
                ),
          ),
        );
      } else {
        _homeBloc.add(
          UpdateTaskEvent(
            (listWidgetSection[oldIndex] as ItemTask).task.copyWith(
                  sectionId: idSectionBelow,
                ),
          ),
        );
      }
    }
  }

  String getIdSectionBellow(
      int newIndex, int oldIndex, List<Widget> listWidgetSection) {
    final smallerIndex = newIndex < oldIndex ? newIndex : oldIndex;
    final biggerIndex = newIndex > oldIndex ? newIndex : oldIndex;

    for (int i = biggerIndex; i >= smallerIndex; i--) {
      if (listWidgetSection[i] is HeaderSection) {
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

  List<Widget> getListWidgetSection(List<Section> listSection) {
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
        listWidget.add(
          ItemTask(
            key: ValueKey(task.id),
            task: task,
            updateTask: (task) {
              _homeBloc.add(UpdateTaskEvent(task));
            },
            onPressed: (Task task) {
              Navigator.of(context)
                  .pushNamed(AppRouter.kDetailTask, arguments: task);
            },
          ),
        );
      }
    }
    return listWidget;
  }
}
