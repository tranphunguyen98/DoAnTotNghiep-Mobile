import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/submit_task/task_submit_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_item_section.dart';

class ListSection extends StatelessWidget {
  final List<Task> listTask;
  final List<Section> listSection;
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  ListSection(this.listTask, this.listSection);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskSubmitBloc, TaskSubmitState>(
      cubit: _taskSubmitBloc,
      listener: (context, state) {
        if (state.success) {
          getIt<TaskBloc>().add(DataListTaskChanged());
          _taskSubmitBloc.add(HandledSuccessState());
        }
      },
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (context, index) {
          bool checkItemTaskGetListTaskWithSection(Task task, Section section) {
            final bool isHaveSectionId = task.sectionId == section.id;
            final bool isNotHaveSectionId =
                listSection[index] == Section.kSectionNoName &&
                    (task.sectionId?.isEmpty ?? true);
            return isHaveSectionId || isNotHaveSectionId;
          }

          return ItemSection(
            section: listSection[index],
            listTask: listTask
                .where((element) => checkItemTaskGetListTaskWithSection(
                    element, listSection[index]))
                .toList(),
          );
        },
        itemCount: listSection.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
