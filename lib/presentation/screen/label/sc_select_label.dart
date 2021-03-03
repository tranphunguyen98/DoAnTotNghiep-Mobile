import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/submit_task/bloc.dart';
import 'package:totodo/bloc/task/bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/label/widget_item_label_check_box.dart';
import 'package:totodo/presentation/screen/task/widget_empty_task.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class SelectLabelScreen extends StatefulWidget {
  @override
  _SelectLabelScreenState createState() => _SelectLabelScreenState();
}

class _SelectLabelScreenState extends State<SelectLabelScreen> {
  final TaskBloc _taskBloc = getIt<TaskBloc>();

  final TaskSubmitBloc _taskSubmitBloc = getIt<TaskSubmitBloc>();

  List<Label> listAllLabel;

  @override
  Widget build(BuildContext context) {
    print("BUILD SelectLabelScreen");
    listAllLabel = (_taskBloc.state as DisplayListTasks).listLabel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Labels",
          style: kFontMediumWhite_16,
        ),
      ),
      body: listAllLabel.isEmpty
          ? EmptyTask("Danh sách Nhãn rỗng!")
          : BlocBuilder<TaskSubmitBloc, TaskSubmitState>(
              cubit: _taskSubmitBloc,
              builder: (context, state) {
                return ListView(
                  children: [
                    ...listAllLabel
                        .map((e) => ItemLabelCheckBox(
                            label: e,
                            isChecked:
                                state.taskSubmit.labels?.contains(e) ?? false,
                            onCheckBoxChanged: (value) {
                              final newListLabel = <Label>[];
                              newListLabel
                                  .addAll(state.taskSubmit.labels ?? []);
                              if (value == true) {
                                newListLabel.add(e);
                              } else {
                                newListLabel.remove(e);
                              }

                              _taskSubmitBloc
                                  .add(TaskSubmitChanged(labels: newListLabel));
                            }))
                        .toList()
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.of(context).pushNamed(AppRouter.kAddLabel);
          setState(() {
            listAllLabel = (_taskBloc.state as DisplayListTasks).listLabel;
          });
          print("COME BACKKKKKKKKKKKKKk");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
