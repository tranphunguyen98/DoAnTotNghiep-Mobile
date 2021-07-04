import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_image.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/utils/my_const/map_const.dart';
import 'package:totodo/utils/notification_helper.dart';
import 'package:totodo/utils/util.dart';

import '../../data/model/habit/habit_image.dart';
import '../../utils/my_const/map_const.dart';
import '../../utils/util.dart';
import 'bloc.dart';

class CreateHabitBloc extends Bloc<CreateHabitEvent, CreateHabitState> {
  final IHabitRepository _habitRepository;

  CreateHabitBloc({@required IHabitRepository habitRepository})
      : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(CreateHabitState(loading: true));

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
    yield state.copyWith(habit: habit, loading: false);
  }

  // Stream<CreateHabitState> _mapSubmitEditingHabitToState() async* {
  //   final Habit habit =
  //       state.habit.copyWith(updatedAt: DateTime.now().toIso8601String());
  //
  //   await _habitRepository.updateHabit(habit);
  //
  //   //TODO add reminder
  //   // if (!(state.taskAdd.taskDate?.isEmpty ?? true)) {
  //   //   showNotificationScheduledWithTask(taskSubmit);
  //   // }
  //
  //   yield state.copyWith(
  //     success: true,
  //     habit: Habit(),
  //   );
  // }

  Stream<CreateHabitState> _mapSubmitCreatingHabitToState() async* {
    Habit habit = state.habit;

    if (habit.id?.isEmpty ?? true) {
      habit = habit.copyWith(
          id: state.habit.id ?? ObjectId().hexString,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          images: HabitImage(
              imgBg: (habit.icon?.iconImage?.isNotEmpty ?? false)
                  ? kCheckInColor[int.parse(habit.icon.iconImage)]
                  : kCheckInColor[0],
              imgUnCheckIn: habit.icon.iconImage ?? "1",
              imgCheckIn: habit.icon.iconImage ?? "1"));

      log('testNotification', habit);
      showNotificationScheduledWithHabit(habit);
      await _habitRepository.addHabit(habit.copyWith());
    } else {
      //Edit habit
      final oldHabit = await _habitRepository.getDetailHabit(state.habit.id);
      // if (((state.habit.motivation?.images?.isNotEmpty ?? false) &&
      //         state.habit.motivation.images.length <= 2) &&
      //     state.habit.motivation.images != oldHabit.motivation.images) {
      // habit = await saveImages(habit);
      // }
      if (habit.remind != oldHabit.remind) {
        for (final remind in oldHabit.remind) {
          await AwesomeNotifications().cancelSchedule(
              '${habit.id}${remind.minute}${remind.hour}'.hashCode);
        }
        showNotificationScheduledWithHabit(habit);
      }

      if (oldHabit.icon != habit.icon) {
        if (isInt(habit.icon.iconImage)) {
          final int valueIcon = int.parse(habit.icon.iconImage);
          habit = habit.copyWith(
            images: HabitImage(
                imgBg: kCheckInColor[valueIcon],
                imgUnCheckIn: habit.icon.iconImage,
                imgCheckIn: habit.icon.iconImage),
          );
        } else if (habit.icon.iconText?.isNotEmpty ?? false) {
          habit = habit.copyWith(
            images: HabitImage(
                imgBg: kCheckInColor[1], imgUnCheckIn: "1", imgCheckIn: "1"),
          );
        }
      }
      habit = habit.copyWith(updatedAt: DateTime.now().toIso8601String());
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

  // Future<Habit> saveImages(Habit habit) async {
  //   if (habit.motivation?.images?.isNotEmpty ?? false) {
  //     final List<String> newImagePaths = [];
  //     habit.motivation.images.forEach((imagePath) async {
  //       if (imagePath.contains(kLocalFolder)) {
  //         final imageFilePath =
  //             "${ObjectId().hexString}${getExtensionFromPath(imagePath)}";
  //         final newPath =
  //             await saveImageFromGallery(imagePath, habit.id, imageFilePath);
  //         newImagePaths.add(newPath);
  //       } else {
  //         return imagePath;
  //       }
  //     });
  //     return habit.copyWith(
  //         motivation: habit.motivation.copyWith(images: newImagePaths));
  //     log('testImage', newImagePaths);
  //   }
  //   return habit;
  // }

  Stream<CreateHabitState> _mapCreatingHabitDataChangedToState(
      CreatingHabitDataChanged event) async* {
    var habit = state.habit;
    habit = habit.copyWith(name: event.name);
    habit = habit.copyWith(icon: event.icon);
    habit = habit.copyWith(motivation: event.motivation);
    habit = habit.copyWith(type: event.type);
    habit = habit.copyWith(frequency: event.frequency);
    habit = habit.copyWith(remind: event.remind);
    habit = habit.copyWith(missionDayUnit: event.missionDayUnit);
    habit = habit.copyWith(missionDayCheckInStep: event.missionDayCheckInStep);
    habit = habit.copyWith(missionDayTarget: event.missionDayTarget);
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
