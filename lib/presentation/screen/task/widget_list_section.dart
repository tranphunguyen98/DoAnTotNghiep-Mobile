import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/submit_task/task_submit_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/section.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_item_section.dart';

class ListSection extends StatelessWidget {
  final List<Section> listSection;
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  ListSection(this.listSection);

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
          return ItemSection(
            section: listSection[index],
          );
        },
        itemCount: listSection.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
