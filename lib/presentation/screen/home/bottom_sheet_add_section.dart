import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/section/bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/common_widgets/widget_circle_inkwell.dart';
import 'package:totodo/presentation/common_widgets/widget_text_field_non_border.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class BottomSheetAddSection extends StatelessWidget {
  final _addSectionBloc = getIt<AddSectionBloc>();
  final _taskBloc = getIt<TaskBloc>();
  final _textNameSectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addSectionBloc.add(ProjectIdSectionAddChanged(
        projectId:
            (_taskBloc.state as DisplayListTasks).getProjectSelected().id));
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: BlocConsumer<AddSectionBloc, AddSectionState>(
        cubit: _addSectionBloc,
        listener: (context, state) {
          if (state.isSuccess == true) {
            _taskBloc.add(DataListSectionChanged());
          }
        },
        builder: (context, state) {
          //_intData(_taskBloc.state as DisplayListTasks);
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextNameTask(state, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextNameTask(AddSectionState state, BuildContext context) {
    print("build text $state}");
    // _textNameTaskController
    //   ..text = state.section.name ?? ''
    //   ..selection =
    //   TextSelection.collapsed(offset: state.taskSubmit.name?.length ?? 0);

    return Row(
      children: [
        Expanded(
          child: TextFieldNonBorder(
              hint: 'Tên Section',
              controller: _textNameSectionController,
              onChanged: (value) {
                _addSectionBloc.add(NameSectionAddChanged(name: value));
              },
              errorText:
                  state.isValidNameSection ? null : 'Tên không được rỗng'),
        ),
        SizedBox(
          width: 8,
        ),
        CircleInkWell(
          Icons.send,
          sizeIcon: 24,
          colorIcon: state.isValidNameSection ? Colors.red : kColorGray1,
          onPressed: state.isValidNameSection
              ? () {
                  _addSectionBloc.add(AddSectionSubmit());
                  Navigator.pop(context);
                }
              : null,
        )
      ],
    );
  }
}
