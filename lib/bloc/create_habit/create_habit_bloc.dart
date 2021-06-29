import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/utils/file_helper.dart';
import 'package:totodo/utils/notification_helper.dart';
import 'package:totodo/utils/util.dart';

import 'bloc.dart';

class CreateHabitBloc extends Bloc<CreateHabitEvent, CreateHabitState> {
  final IHabitRepository _habitRepository;

  CreateHabitBloc({@required IHabitRepository habitRepository})
      : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(CreateHabitState());

  @override
  Stream<CreateHabitState> mapEventToState(CreateHabitEvent event) async* {
    if (event is OpenScreenCreateHabit) {
      yield* _mapOpenScreenCreateHabitToState(event.habit);
    } else if (event is CreatingHabitDataChanged) {
      yield* _mapCreatingHabitDataChangedToState(event);
    } else if (event is SubmitCreatingHabit) {
      yield* _mapSubmitCreatingHabitToState();
    } else if (event is AddError) {
      yield* _mapAddErrorToState(event.error);
    }
  }

  Stream<CreateHabitState> _mapOpenScreenCreateHabitToState(
      Habit habit) async* {
    yield state.copyWith(habit: habit);
  }

  Stream<CreateHabitState> _mapSubmitEditingHabitToState() async* {
    final Habit habit =
        state.habit.copyWith(updatedAt: DateTime.now().toIso8601String());

    await _habitRepository.updateHabit(habit);

    //TODO add reminder
    // if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
    //   showNotificationScheduledWithTask(taskSubmit);
    // }

    yield state.copyWith(
      success: true,
      habit: Habit(),
    );
  }

  Stream<CreateHabitState> _mapSubmitCreatingHabitToState() async* {
    Habit habit = state.habit;

    if (state.habit.id?.isEmpty ?? true) {
      await saveImages();
      habit = state.habit.copyWith(
        id: state.habit.id ?? ObjectId().hexString,
        createdAt: DateTime.now().toIso8601String(),
      );
      log('testNotification', habit);
      showNotificationScheduledWithHabit(habit);
      await _habitRepository.addHabit(habit);
    } else {
      //Edit habit
      final oldHabit = await _habitRepository.getDetailHabit(state.habit.id);
      if ((state.habit.motivation?.images?.isNotEmpty ?? false) &&
          state.habit.motivation.images != oldHabit.motivation.images) {
        await saveImages();
      }
      habit = state.habit.copyWith(updatedAt: DateTime.now().toIso8601String());
      await AwesomeNotifications().cancelSchedule(habit.id.hashCode);
      showNotificationScheduledWithHabit(habit);
      await _habitRepository.updateHabit(habit);
    }

    //TODO add reminder

    // showNotificationScheduledWithTask(task)
    yield state.copyWith(
      success: true,
      habit: Habit(),
    );
  }

  Future<void> saveImages() async {
    if (state.habit.motivation?.images?.isNotEmpty ?? false) {
      final List<String> newImagePaths = [];
      state.habit.motivation.images.forEach((imagePath) async {
        final newPath = await saveImage(
            imagePath, ObjectId().hexString + getExtensionFromPath(imagePath));
        newImagePaths.add(newPath);
      });
      state.habit.copyWith(
          motivation: state.habit.motivation.copyWith(images: newImagePaths));
      log('testImage', newImagePaths);
    }
  }

  Stream<CreateHabitState> _mapCreatingHabitDataChangedToState(
      CreatingHabitDataChanged event) async* {
    var habit = state.habit;
    habit = habit.copyWith(name: event.name);
    habit = habit.copyWith(icon: event.icon);
    habit = habit.copyWith(motivation: event.motivation);
    habit = habit.copyWith(type: event.type);
    habit = habit.copyWith(frequency: event.frequency);
    habit = habit.copyWith(reminds: event.reminds);
    habit = habit.copyWith(missionDayUnit: event.missionDayUnit);
    habit = habit.copyWith(missionDayCheckInStep: event.missionDayCheckInStep);
    habit = habit.copyWith(totalDayAmount: event.totalDayAmount);
    habit = habit.copyWith(typeHabitGoal: event.typeHabitGoal);
    habit = habit.copyWith(
        typeHabitMissionDayCheckIn: event.typeHabitMissionDayCheckIn);
    yield state.copyWith(
        habit: habit,
        msg: habit.name?.isNotEmpty ?? false ? '' : 'Tên không được rỗng');
  }

  Stream<CreateHabitState> _mapAddErrorToState(String error) async* {
    yield state.copyWith(msg: error);
  }
}
