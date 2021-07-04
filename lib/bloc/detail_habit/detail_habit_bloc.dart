import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/utils/file_helper.dart';
import 'package:totodo/utils/util.dart';

import '../../utils/my_const/map_const.dart';
import 'bloc.dart';

class DetailHabitBloc extends Bloc<DetailHabitEvent, DetailHabitState> {
  final IHabitRepository _habitRepository;

  DetailHabitBloc({
    @required IHabitRepository habitRepository,
  })  : assert(habitRepository != null),
        _habitRepository = habitRepository,
        super(DetailHabitState.loading());

  @override
  Stream<DetailHabitState> mapEventToState(DetailHabitEvent event) async* {
    if (event is InitDataDetailHabit) {
      yield* _mapInitDataDetailHabitToState(event.habit, event.chosenDay);
    } else if (event is CheckInHabit) {
      yield* _mapCheckInHabitToState(event.checkIn);
    } else if (event is AddDiary) {
      yield* _mapAddDiaryToState(event.item, event.date);
    } else if (event is DeleteHabit) {
      yield* _mapDeleteHabitToState();
    } else if (event is ArchiveHabit) {
      yield* _mapArchiveHabitToState();
    } else if (event is UpdateDataDetailHabit) {
      yield* _mapUpdateDataDetailHabitToState();
    } else if (event is ChosenDayChanged) {
      yield* _mapChosenDayChangedToState(event.chosenDay);
    }
  }

  Stream<DetailHabitState> _mapChosenDayChangedToState(String date) async* {
    yield state.copyWith(chosenDay: date);
  }

  Stream<DetailHabitState> _mapInitDataDetailHabitToState(
      Habit habit, String chosenDay) async* {
    yield state.copyWith(
        habit: habit,
        chosenDay: chosenDay,
        chosenMonth: DateTime.now().toIso8601String());
  }

  Stream<DetailHabitState> _mapAddDiaryToState(
      Diary diaryItem, String dateString) async* {
    final List<String> newImagePaths = [];
    if (diaryItem.images?.isNotEmpty ?? false) {
      for (final imagePath in diaryItem.images) {
        final imageFilePath =
            "${ObjectId().hexString}${getExtensionFromPath(imagePath)}";
        final newPath = await saveImageFromGallery(
            imagePath, state.habit.id, imageFilePath);
        newImagePaths.add(newPath);
      }
      diaryItem.images.forEach((imagePath) async {});
      log('testImage', newImagePaths);
    }

    await _habitRepository.addDiary(
        state.habit.id,
        diaryItem.copyWith(
          images: newImagePaths,
          habit: state.habit.id,
          updatedAt: DateTime.now().toIso8601String(),
          createdAt: DateTime.now().toIso8601String(),
          time: DateTime.parse(dateString).toIso8601String(),
        ));
  }

  Future<void> saveImages() async {
    if (state.habit.motivation?.images?.isNotEmpty ?? false) {
      final List<String> newImagePaths = [];
      for (final imagePath in state.habit.motivation.images) {
        final imageFilePath =
            "${ObjectId().hexString}${getExtensionFromPath(imagePath)}";
        final newPath = await saveImageFromGallery(
            imagePath, state.habit.id, imageFilePath);
        newImagePaths.add(newPath);
      }
      state.habit.copyWith(
          motivation: state.habit.motivation.copyWith(images: newImagePaths));
      log('testImage', newImagePaths);
    }
  }

  Stream<DetailHabitState> _mapDeleteHabitToState() async* {
    final habit = state.habit.copyWith(isTrashed: true);
    await _habitRepository.deleteHabit(habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapCheckInHabitToState(int amount) async* {
    await _habitRepository.checkInHabit(state.habit, state.chosenDay, amount);
    final habit = await _habitRepository.getDetailHabit(state.habit.id);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapArchiveHabitToState() async* {
    final habit = state.habit.copyWith(isFinished: true);
    await _habitRepository.updateHabit(habit);
    yield state.copyWith(habit: habit);
  }

  Stream<DetailHabitState> _mapUpdateDataDetailHabitToState() async* {
    final Habit updatedHabit =
        await _habitRepository.getDetailHabit(state.habit.id);
    yield state.copyWith(
        habit: updatedHabit.copyWith(
            images: updatedHabit.images.copyWith(
      imgBg: updatedHabit.images.imgBg ?? kCheckInColor[1],
      imgUnCheckIn: updatedHabit.images.imgUnCheckIn ?? "1",
      imgCheckIn: updatedHabit.images.imgCheckIn ?? "1",
    )));
  }
}
