import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/submit_task/task_submit_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/task/widget_item_task.dart';

class ListTask extends StatelessWidget {
  final List<Task> listTask;
  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();
  ListTask(this.listTask);

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
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemBuilder: (context, index) {
          return ItemTask(
            listTask[index],
            (task) {
              _taskSubmitBloc.add(SubmitEditTask(task));
            },
            onPressed: (Task task) {
              Navigator.of(context)
                  .pushNamed(AppRouter.kDetailTask, arguments: task);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1.0,
          );
        },
        itemCount: listTask.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
