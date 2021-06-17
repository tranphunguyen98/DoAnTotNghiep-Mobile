import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/add_task/bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/repository_interface/i_task_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/dropdown_choice.dart';
import 'package:totodo/presentation/screen/home/widget_bottom_sheet_add_task.dart';
import 'package:totodo/utils/my_const/color_const.dart';

class HeaderSection extends StatelessWidget {
  final String sectionName;
  final String sectionId;
  final TextStyle style;
  final bool expandFlag;
  final Project project;
  final VoidCallback onExpand;

  HeaderSection({
    @required this.sectionName,
    @required this.sectionId,
    @required this.style,
    @required this.expandFlag,
    @required this.onExpand,
    this.project,
    Key key,
  }) : super(key: key);

  final List<DropdownChoices> dropdownChoices = [];

  @override
  Widget build(BuildContext context) {
    _intData();

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 20.0,
                bottom: 16.0,
              ),
              child: Text(sectionName, style: style),
            ),
            const Spacer(),
            if (getIt<HomeBloc>().state.isInProject())
              PopupMenuButton<DropdownChoices>(
                onSelected: (DropdownChoices choice) {
                  choice.onPressed(context);
                },
                elevation: 6,
                icon: Icon(
                  Icons.more_vert,
                  color: kColorBlack2,
                ),
                itemBuilder: (BuildContext context) {
                  return dropdownChoices.map((DropdownChoices choice) {
                    return PopupMenuItem<DropdownChoices>(
                      value: choice,
                      child: Text(choice.title),
                    );
                  }).toList();
                },
              ),
          ],
        ),
        const Divider(
          thickness: 1.0,
          height: 1.0,
        )
      ],
    );
  }

  void _intData() {
    dropdownChoices.clear();
    dropdownChoices.addAll([
      DropdownChoices(
          title: 'Thêm Task',
          onPressed: (context) {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
              ),
              context: Scaffold.of(context).context,
              builder: (_) => BlocProvider<TaskAddBloc>(
                create: (context) => TaskAddBloc(
                  taskRepository: getIt<ITaskRepository>(),
                )..add(OnDataTaskAddChanged()),
                child: BottomSheetAddTask(
                  sectionId: sectionId,
                  projectSelected: project,
                ),
              ),
            );
            //Navigator.pushNamed(context, MyRouter.SETTING);
          }),
      DropdownChoices(title: 'Sửa tên section', onPressed: (context) {}),
      DropdownChoices(
          title: 'Xóa section',
          onPressed: (context) {
            getIt<HomeBloc>().add(DeleteSectionEvent(sectionId, project.id));
          }),
    ]);
  }
}
