import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/task/widget_empty_task.dart';
import 'package:totodo/presentation/screen/task/widget_list_section.dart';
import 'package:totodo/utils/my_const/font_const.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
        cubit: getIt<TaskBloc>(),
        // buildWhen: (previous, current) {
        //   print("previous $previous current $current");
        //   if (previous is DisplayListTasks && current is DisplayListTasks) {
        //     print("DashboardScreen previous: ${previous.listDataDisplay()}");
        //     print("DashboardScreen current: ${current.listDataDisplay()}");
        //
        //     print(previous.listDataDisplay() != current.listDataDisplay());
        //     return (previous.listDataDisplay() != current.listDataDisplay());
        //   }
        //   return false;
        // },
        builder: (context, state) {
          print("DashboardScreen $state");
          if (state is DisplayListTasks) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.listSectionDataDisplay() != null) {
              if (state.listSectionDataDisplay().isEmpty) {
                return const EmptyTask();
              } else {
                return ListSection(state.listSectionDataDisplay());
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
