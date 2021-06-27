import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/router.dart';
import 'package:totodo/presentation/screen/home/bottom_sheet_add_section.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import 'dropdown_choice.dart';

class PopupMenuButtonMore extends StatefulWidget {
  @override
  _PopupMenuButtonMoreState createState() => _PopupMenuButtonMoreState();
}

class _PopupMenuButtonMoreState extends State<PopupMenuButtonMore> {
  final _homeBloc = getIt<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: _homeBloc,
      buildWhen: (previous, current) =>
          previous.loading != current.loading ||
          previous.indexDrawerSelected != current.indexDrawerSelected ||
          previous.isShowCompletedTask != current.isShowCompletedTask,
      builder: (context, state) {
        final dropdownChoices = getDropdownChoices(state);
        return PopupMenuButton<DropdownChoices>(
          onSelected: (DropdownChoices choice) {
            choice.onPressed(context);
          },
          elevation: 6,
          icon: Icon(
            Icons.more_vert,
            color: kColorWhite,
          ),
          itemBuilder: (BuildContext context) {
            return dropdownChoices.map((DropdownChoices choice) {
              return PopupMenuItem<DropdownChoices>(
                value: choice,
                child: Text(choice.title),
              );
            }).toList();
          },
        );
      },
    );
  }

  List<DropdownChoices> getDropdownChoices(HomeState state) {
    final dropdownChoices = <DropdownChoices>[];
    dropdownChoices.addAll([
      DropdownChoices(
          title: state.isShowCompletedTask
              ? 'Ẩn nhiệm vụ đã hoàn thành'
              : 'Hiển thị nhiệm vụ đã hoàn thành',
          onPressed: (context) {
            _homeBloc.add(ShowCompletedTaskChange());
          })
    ]);
    if (state.isInProject()) {
      dropdownChoices.addAll([
        DropdownChoices(
          title: "Thêm section",
          onPressed: (context) {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0)),
              ),
              // context: scaffoldKey.currentContext,
              context: context,
              builder: (_) => BottomSheetAddSection(),
            );
          },
        ),
        DropdownChoices(
            title: "Chỉnh sửa dự án",
            onPressed: (context) {
              Navigator.of(context).pushNamed(AppRouter.kAddProject,
                  arguments: _homeBloc
                      .state
                      .drawerItems[_homeBloc.state.indexDrawerSelected]
                      .data as Project);
            }),
        DropdownChoices(
            title: "Xóa dự án",
            onPressed: (context) {
              _homeBloc.add(DeleteProject());
            }),
      ]);
    }
    if (state.isInLabel()) {
      dropdownChoices.addAll([
        DropdownChoices(
          title: 'Xóa thẻ',
          onPressed: (context) {
            _homeBloc.add(DeleteLabel());
          },
        ),
        DropdownChoices(
          title: 'Sửa thẻ',
          onPressed: (context) {
            Navigator.of(context).pushNamed(AppRouter.kAddLabel,
                arguments: _homeBloc
                    .state
                    .drawerItems[_homeBloc.state.indexDrawerSelected]
                    .data as Label);
          },
        )
      ]);
    }
    return dropdownChoices;
  }
}
