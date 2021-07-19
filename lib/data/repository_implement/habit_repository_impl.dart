import 'package:dio/dio.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/data_source/habit/local_habit_data_source.dart';
import 'package:totodo/data/data_source/habit/remote_habit_data_source.dart';
import 'package:totodo/data/data_source/user/local_user_data_source.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/user.dart';
import 'package:totodo/data/repository_interface/i_habit_repository.dart';
import 'package:totodo/utils/util.dart';

class HabitRepositoryImpl implements IHabitRepository {
  final RemoteHabitDataSource _remoteHabitDataSource;
  final LocalHabitDataSource _localHabitDataSource;
  final LocalUserDataSource _localUserDataSource;

  HabitRepositoryImpl(this._remoteHabitDataSource, this._localHabitDataSource,
      this._localUserDataSource);

  @override
  Future<void> clearOffline() async {
    _localHabitDataSource.clearOffline();
  }

  @override
  Future<void> addHabit(Habit habit) async {
    final user = await _localUserDataSource.getUser();

    try {
      _remoteHabitDataSource
          .addHabit(user.authorization, habit)
          .then((value) async {
        // final updatedLocalHabit = await _remoteHabitDataSource.getDetailHabit(
        //     user.authorization, habit.id);
        // await _localHabitDataSource.updateHabitAsync(updatedLocalHabit);
      });

      return _localHabitDataSource.addHabit(habit);
    } on DioError catch (e, stackTrace) {
      log('testAsync', 'server error $stackTrace');
    } on Exception catch (e) {
      log('testAsync', 'server error $e');
    }
  }

  @override
  Future<List<Habit>> getHabits() async {
    return (await _localHabitDataSource.getAllHabit())
        .where(
            (element) => element.isTrashed == null || element.isTrashed != true)
        .toList();
  }

  @override
  Future<Habit> getDetailHabit(String id) {
    return _localHabitDataSource.getDetailHabit(id);
  }

  @override
  Future<List<Diary>> getDiaries() {
    return _localHabitDataSource.getDiaries();
  }

  @override
  Future<List<Diary>> getDiaryByHabitId(String habitId) {
    return _localHabitDataSource.getDiaryByHabitId(habitId);
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final user = await _localUserDataSource.getUser();

    _remoteHabitDataSource
        .updateHabit(user.authorization, habit)
        .then((value) async {
      // final updatedLocalTask = await _remoteHabitDataSource.getDetailHabit(
      //     user.authorization, habit.id);
      // await _localHabitDataSource.updateHabitAsync(updatedLocalTask);

      // log('testAsync updated task1',
      //     await _localTaskDataSource.getDetailTask(updatedLocalTask.id));
    });

    return _localHabitDataSource.updateHabit(habit);
  }

  @override
  Future<void> checkInHabit(Habit habit, String chosenDay,
      [int checkInAmount]) async {
    await _localHabitDataSource.checkInHabit(habit, chosenDay, checkInAmount);
    final newHabit = await _localHabitDataSource.getDetailHabit(habit.id);
    updateHabit(newHabit);
  }

  @override
  Future<void> resetHabitOnDay(Habit habit, String chosenDay) {
    return _localHabitDataSource.resetHabitOnDay(habit, chosenDay);
  }

  @override
  Future<void> saveDataOnLocal() async {
    final user = await _localUserDataSource.getUser();
    final habits = await _remoteHabitDataSource.getAllHabit(user.authorization);
    final List<Diary> allDiaries = [];

    List<Future<List<Diary>>> futures = [];
    for (final habit in habits) {
      futures.add(_saveDiariesOfHabit(user, habit));
    }
    final results = await Future.wait(futures);
    for (final result in results) {
      allDiaries.addAll(result);
    }
    // final newHabits = await saveHabitImagesToLocal(habits);
    // final newDiaries = await saveDiaryImagesToLocal(allDiaries);
    await _localHabitDataSource.saveHabits(habits);
    await _localHabitDataSource.saveDiaries(allDiaries);
  }

  Future<List<Diary>> _saveDiariesOfHabit(User user, Habit habit) async {
    final diaries = await _remoteHabitDataSource.getDiaryByHabitId(
        user.authorization, habit.id);
    return diaries;
  }

  // Future<List<Diary>> saveDiaryImagesToLocal(List<Diary> diaries) async {
  //   return Stream.fromIterable(diaries).asyncMap((diary) async {
  //     if ((diary?.images?.isNotEmpty ?? false)) {
  //       final images =
  //           await Stream.fromIterable(diary?.images).asyncMap((image) async {
  //         var imageExtension = getExtensionFromPath(image);
  //         if ((imageExtension?.length ?? 5) > 4) imageExtension = '.jpg';
  //         final pathImage =
  //             '${diary.id}/${ObjectId().hexString}$imageExtension';
  //         final newImagePath = await saveImageFromUrl(image, pathImage);
  //         if (newImagePath != null) {
  //           return newImagePath;
  //         } else {
  //           log('testAsync image null', image);
  //         }
  //       }).toList();
  //       images.removeWhere((element) => element == null);
  //       diary = diary.copyWith(images: images);
  //     }
  //     return diary;
  //   }).toList();
  // }
  //
  // Future<List<Habit>> saveHabitImagesToLocal(List<Habit> habits) async {
  //   final futures = <Future<Habit>>[];
  //   for (final habit in habits) {
  //     futures.add(saveImage(habit));
  //   }
  //
  //   final List<Habit> newHabits = await Future.wait(futures);
  //   return newHabits;
  //   // return Stream.fromIterable(habits).asyncMap((habit) async {
  //   //
  //   // }).toList();
  // }
  //
  // Future<Habit> saveImage(Habit habit) async {
  //   if ((habit.icon.iconImage?.length ?? 3) > 2) {
  //     var imageExtension = getExtensionFromPath(habit.icon.iconImage);
  //     if ((imageExtension?.length ?? 5) > 4) imageExtension = '.jpg';
  //     final pathImage = '${habit.id}/${ObjectId().hexString}$imageExtension';
  //     final fileImagePath =
  //         await saveImageFromUrl(habit.icon.iconImage, pathImage);
  //     if (fileImagePath != null) {
  //       habit =
  //           habit.copyWith(icon: habit.icon.copyWith(iconImage: fileImagePath));
  //     } else {
  //       log('testAsync image null', habit.icon.iconImage);
  //     }
  //   }
  //
  //   if (habit.motivation?.images?.isNotEmpty ?? false) {
  //     final motivationImage = await Stream.fromIterable(habit.motivation.images)
  //         .asyncMap((image) async {
  //       var imageExtension = getExtensionFromPath(image);
  //       if ((imageExtension?.length ?? 5) > 4) imageExtension = '.jpg';
  //       final pathImage = '${habit.id}/${ObjectId().hexString}$imageExtension';
  //       final newImagePath = await saveImageFromUrl(image, pathImage);
  //       if (newImagePath != null) {
  //         return newImagePath;
  //       } else {
  //         log('testAsync image null', image);
  //       }
  //     }).toList();
  //     motivationImage.removeWhere((element) => element == null);
  //     habit = habit.copyWith(
  //         motivation: habit.motivation.copyWith(images: motivationImage));
  //   }
  //
  //   if ((habit.images.imgUnCheckIn?.length ?? 0) > 2) {
  //     var imageExtension = getExtensionFromPath(habit.images.imgUnCheckIn);
  //     if ((imageExtension?.length ?? 0) > 4) imageExtension = '.jpg';
  //     final pathImage = '${habit.id}/${ObjectId().hexString}$imageExtension';
  //     final fileImagePath =
  //         await saveImageFromUrl(habit.images.imgUnCheckIn, pathImage);
  //
  //     //TODO change path local
  //
  //     if (fileImagePath != null) {
  //       habit = habit.copyWith(
  //           images: habit.images.copyWith(imgUnCheckIn: fileImagePath));
  //     } else {
  //       log('testAsync image null', habit.icon.iconImage);
  //     }
  //   }
  //
  //   return habit;
  // }

  @override
  Future<void> addDiary(String habitId, Diary diary) async {
    final user = await _localUserDataSource.getUser();
    diary = diary.copyWith(id: ObjectId().hexString);
    try {
      // _remoteHabitDataSource.addDiary(user.authorization, habitId, diary);

      return _localHabitDataSource.addDiary(diary);
    } on DioError catch (e, stackTrace) {
      log('testAsync', 'server error $stackTrace');
    } on Exception catch (e) {
      log('testAsync', 'server error $e');
    }
  }

  @override
  Future<void> deleteHabit(Habit habit) async {
    final user = await _localUserDataSource.getUser();

    _remoteHabitDataSource.deleteHabit(user.authorization, habit).then((value) {
      _localHabitDataSource.deletePermanentlyHabit(habit);
    });

    return _localHabitDataSource.updateHabit(habit.copyWith(isTrashed: true));
  }
}
