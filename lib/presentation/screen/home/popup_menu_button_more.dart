import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totodo/bloc/home/bloc.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/home/bottom_sheet_add_section.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import 'dropdown_choice.dart';

class PopupMenuButtonMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      cubit: getIt<HomeBloc>(),
      buildWhen: (previous, current) =>
          previous.loading != current.loading ||
          previous.indexDrawerSelected != current.indexDrawerSelected,
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
    if (state.checkIsInProject()) {
      dropdownChoices.addAll([
        DropdownChoices(
            title: "Chỉnh sửa dự án",
            onPressed: (context) {
              //Navigator.pushNamed(context, MyRouter.SETTING);
            }),
        DropdownChoices(
          title: "Thêm Section",
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
      ]);
    }
    return dropdownChoices;
  }
}
