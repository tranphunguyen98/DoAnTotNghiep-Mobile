import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';

import '../../../bloc/section/bloc.dart';
import '../../../di/injection.dart';
import '../../../utils/my_const/my_const.dart';
import '../../common_widgets/widget_circle_inkwell.dart';
import '../../common_widgets/widget_text_field_non_border.dart';

class BottomSheetAddSection extends StatelessWidget {
  final _addSectionBloc =
      AddSectionBloc(taskRepository: getIt<ITaskRepository>());
  final _homeBloc = getIt<HomeBloc>();
  final _textNameSectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addSectionBloc.add(ProjectIdSectionAddChanged(
        projectId: (_homeBloc.state).getProjectSelected().id));
    return BlocConsumer<AddSectionBloc, AddSectionState>(
      cubit: _addSectionBloc,
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess,
      listener: (context, state) {
        if (state.isSuccess == true) {
          _homeBloc.add(DataProjectChanged());
        }
        Navigator.pop(context);
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextNameTask(state, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextNameTask(AddSectionState state, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldNonBorder(
              hint: 'Tkn Section',
              controller: _textNameSectionController,
              onChanged: (value) {
                _addSectionBloc.add(NameSectionAddChanged(name: value));
              },
              errorText:
                  state.isValidNameSection ? null : 'Tên không được rỗng'),
        ),
        const SizedBox(
          width: 8,
        ),
        CircleInkWell(
          Icons.send,
          size: 24,
          color: state.isValidNameSection ? Colors.red : kColorGray1,
          onPressed: state.isValidNameSection
              ? () {
                  _addSectionBloc.add(AddSectionSubmit());
                  // Navigator.pop(context);
                }
              : null,
        )
      ],
    );
  }
}
