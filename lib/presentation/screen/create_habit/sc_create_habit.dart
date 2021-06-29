import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:totodo/bloc/create_habit/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/di/injection.dart';
import 'package:totodo/presentation/screen/create_habit/body_creating_habit_step_1.dart';
import 'package:totodo/presentation/screen/create_habit/body_creating_habit_step_2.dart';
import 'package:totodo/presentation/screen/create_habit/creating_habit_step.dart';
import 'package:totodo/utils/my_const/color_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

class CreateHabitScreen extends StatefulWidget {
  final Habit _habit;

  const CreateHabitScreen([this._habit]);

  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  CreateHabitBloc _createHabitBloc;

  @override
  void initState() {
    _createHabitBloc =
        CreateHabitBloc(habitRepository: getIt<IHabitRepository>());
    if (widget._habit != null) {
      _createHabitBloc.add(OpenScreenCreateHabit(widget._habit));
    } else {
      _createHabitBloc.add(CreatingHabitDataChanged(
          icon: HabitIcon(iconImage: kListIconDefault[0])));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateHabitBloc>(
      create: (context) => _createHabitBloc,
      child: ChangeNotifierProvider<CreatingHabitStep>(
        create: (context) => CreatingHabitStep(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kColorWhite,
            elevation: 0.0,
            title: Text(
              'Tạo thói quen',
              style: kFontMediumBlack_18,
            ),
          ),
          body: Consumer<CreatingHabitStep>(builder: (context, value, child) {
            return Column(
              children: [
                Expanded(
                    child: value.index == CreatingHabitStep.kStep1
                        ? BodyCreatingHabitStep1(widget._habit)
                        : BodyCreatingHabitStep2()),
                _buildBottomContainer(value)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBottomContainer(CreatingHabitStep _step) {
    return BlocConsumer<CreateHabitBloc, CreateHabitState>(
      cubit: _createHabitBloc,
      listenWhen: (previous, current) => previous.success != current.success,
      listener: (context, state) {
        if (state.success) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: kColorWhite,
          child: ElevatedButton(
            onPressed: () {
              _onClickButton(state, _step);
            },
            child: Text(
              _step.index == CreatingHabitStep.kStep1 ? 'Tiếp tục' : 'Lưu',
              style: kFontMediumWhite_12,
            ),
          ),
        );
      },
    );
  }

  void _onClickButton(CreateHabitState state, CreatingHabitStep _step) {
    if (state?.habit?.name?.isEmpty ?? true) {
      _createHabitBloc.add(AddError('Tên không được rỗng'));
      return;
    }
    if (_step.index == CreatingHabitStep.kStep1) {
      _createHabitBloc.add(AddError(''));
      _step.index = CreatingHabitStep.kStep2;
    } else {
      _createHabitBloc.add(SubmitCreatingHabit());
    }
  }
}
