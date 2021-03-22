import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/data/entity/label.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../../bloc/select_label/bloc.dart';
import '../label/widget_item_label_check_box.dart';
import '../task/widget_empty_task.dart';

class SelectLabelScreen extends StatefulWidget {
  final List<Label> listLabelSelected;

  const SelectLabelScreen([this.listLabelSelected]);
  @override
  _SelectLabelScreenState createState() => _SelectLabelScreenState();
}

class _SelectLabelScreenState extends State<SelectLabelScreen> {
  SelectLabelBloc _selectLabelBloc;

  @override
  void initState() {
    _selectLabelBloc = BlocProvider.of<SelectLabelBloc>(context);
    _selectLabelBloc
        .add(InitDataSelectLabel(listLabelSelected: widget.listLabelSelected));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Labels",
          style: kFontMediumWhite_16,
        ),
      ),
      body: BlocBuilder<SelectLabelBloc, SelectLabelState>(
        builder: (context, state) {
          if (state.listAllLabel.isEmpty) {
            return const EmptyTask("Danh sách Nhãn rỗng!");
          }
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, state.listLabelSelected);
              return false;
            },
            child: ListView(
              children: [
                ...state.listAllLabel
                    .map(
                      (label) => ItemLabelCheckBox(
                        label: label,
                        isChecked:
                            state.listLabelSelected.contains(label) ?? false,
                        onCheckBoxChanged: (value) {
                          if (value == true) {
                            _selectLabelBloc
                                .add(AddLabelSelected(label: label));
                          } else {
                            _selectLabelBloc
                                .add(RemoveLabelSelected(label: label));
                          }
                        },
                      ),
                    )
                    .toList()
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(AppRouter.kAddLabel);
          _selectLabelBloc.add(DataListLabelChanged());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
