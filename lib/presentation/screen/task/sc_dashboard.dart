import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_empty_task.dart';
import 'package:totodo/presentation/screen/task/widget_list_task.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
        cubit: getIt<TaskBloc>(),
        builder: (context, state) {
          if (state is DisplayListTasks) {
            if (state.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.listAllTask != null) {
              if (state.listAllTask.isEmpty) {
                return EmptyTask();
              } else {
                return ListTask(state.listAllTask);
              }
            }

            if (state.msg != null) {
              print("Error: ${state.msg}");
              return Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(state.msg, style: kFontRegularGray4_14),
                  ),
                ),
              );
            }

            return Container();
          } else {
            return Container();
          }
        });
  }
}
