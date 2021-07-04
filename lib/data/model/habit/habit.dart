import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/model/habit/habit_frequency.dart';
import 'package:totodo/data/model/habit/habit_image.dart';
import 'package:totodo/data/model/habit/habit_motivation.dart';
import 'package:totodo/data/model/habit/habit_progress_item.dart';
import 'package:totodo/data/model/habit/habit_remind.dart';
import 'package:totodo/utils/cron_helper.dart';
import 'package:totodo/utils/date_helper.dart';
import 'package:totodo/utils/my_const/hive_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import '../../../utils/util.dart';
import 'habit_icon.dart';

part 'habit.g.dart';

@HiveType(typeId: kHiveTypeHabit)
class Habit extends Equatable {
  //TODO add default images
  //TODO habitTotalDay ??
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final HabitIcon icon;
  @HiveField(3)
  final HabitImage images;
  @HiveField(4)
  final bool isSaveDiary;
  @HiveField(5)
  final List<HabitRemind> remind;
  @HiveField(6)
  final HabitMotivation motivation;
  @HiveField(7)
  final int missionDayUnit;
  @HiveField(8)
  final int missionDayCheckInStep;
  @HiveField(9)
  final int missionDayTarget;
  @HiveField(10)
  final bool isFinished;
  @HiveField(11)
  final List<HabitProgressItem> habitProgress;
  @HiveField(12)
  final int type; //TODO additional
  @HiveField(13)
  final HabitFrequency frequency;
  @HiveField(14)
  final int typeHabitMissionDayCheckIn;
  @HiveField(15)
  final int typeHabitGoal;
  @HiveField(16)
  final String createdAt;
  @HiveField(17)
  final bool isTrashed;
  @HiveField(18)
  final String updatedAt;
  @HiveField(19)
  final bool isCreatedOnLocal;

  String get cronDay {
    if (frequency.typeFrequency == EHabitFrequency.daily.index) {
      return CronHelper.instance.dailyDays(frequency.dailyDays,
          referenceUtcDate: DateHelper.dateOnlyWithStringDate(createdAt));
    } else if (frequency.typeFrequency == EHabitFrequency.weekly.index) {
      return CronHelper.instance.daily(
          referenceUtcDate: DateHelper.dateOnlyWithStringDate(createdAt));
    }
    return "";
  }

  String cronReminder(HabitRemind remind) {
    if (frequency.typeFrequency == EHabitFrequency.daily.index) {
      return CronHelper.instance.dailyDays(frequency.dailyDays,
          referenceUtcDate: DateHelper.timeDateWithStringDate(
                  createdAt, remind.hour, remind.minute)
              .toUtc());
    } else if (frequency.typeFrequency == EHabitFrequency.weekly.index) {
      return CronHelper.instance.daily(
          referenceUtcDate: DateHelper.timeDateWithStringDate(
                  createdAt, remind.hour, remind.minute)
              .toUtc());
    }
    return "";
  }

  int get totalDay {
    return habitProgress?.where((element) => element.isDone)?.length ?? 0;
  }

  bool isDoneOnDay(String day) {
    for (final habitProgress in habitProgress) {
      if (DateHelper.isSameDayString(habitProgress.date, day)) {
        return habitProgress.isDone;
      }
    }

    return false;
  }

  int currentAmountOnDay(String day) {
    for (final habitProgress in habitProgress) {
      if (DateHelper.isSameDayString(habitProgress.date, day)) {
        return habitProgress.current;
      }
    }

    return 0;
  }

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Habit({
    this.id,
    this.name,
    this.icon,
    this.images,
    this.isSaveDiary = true,
    this.motivation = const HabitMotivation(content: ''),
    this.missionDayUnit = 0, // 0: Count
    this.missionDayCheckInStep = 1,
    this.missionDayTarget = 1,
    this.typeHabitMissionDayCheckIn = 0, // 0: Auto
    this.typeHabitGoal = 0, //0: completeAll
    this.isFinished = false,
    this.isTrashed = false,
    this.isCreatedOnLocal = false,
    this.type = 0,
    this.createdAt,
    this.updatedAt,
    List<HabitRemind> remind,
    HabitFrequency frequency,
    List<HabitProgressItem> habitProgress,
  })  : frequency = frequency ??
            HabitFrequency(
              typeFrequency: EHabitFrequency.daily.index,
              dailyDays: kDailyDays.keys.toList(),
              intervalDays: 2,
              weeklyDays: 1,
            ),
        remind = remind ?? <HabitRemind>[],
        habitProgress = habitProgress ?? <HabitProgressItem>[];

  Habit copyWith({
    String id,
    String name,
    HabitIcon icon,
    HabitImage images,
    bool isSaveDiary,
    List<HabitRemind> remind,
    HabitMotivation motivation,
    int missionDayUnit,
    int missionDayCheckInStep,
    int missionDayTarget,
    bool isFinished,
    List<HabitProgressItem> habitProgress,
    int type,
    HabitFrequency frequency,
    int typeHabitMissionDayCheckIn,
    int typeHabitGoal,
    String createdAt,
    bool isTrashed,
    String updatedAt,
    bool isCreatedOnLocal,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (isCreatedOnLocal == null ||
            identical(isCreatedOnLocal, this.isCreatedOnLocal)) &&
        (icon == null || identical(icon, this.icon)) &&
        (images == null || identical(images, this.images)) &&
        (isSaveDiary == null || identical(isSaveDiary, this.isSaveDiary)) &&
        (remind == null || identical(remind, this.remind)) &&
        (motivation == null || identical(motivation, this.motivation)) &&
        (missionDayUnit == null ||
            identical(missionDayUnit, this.missionDayUnit)) &&
        (missionDayCheckInStep == null ||
            identical(missionDayCheckInStep, this.missionDayCheckInStep)) &&
        (missionDayTarget == null ||
            identical(missionDayTarget, this.missionDayTarget)) &&
        (isFinished == null || identical(isFinished, this.isFinished)) &&
        (habitProgress == null ||
            identical(habitProgress, this.habitProgress)) &&
        (type == null || identical(type, this.type)) &&
        (frequency == null || identical(frequency, this.frequency)) &&
        (typeHabitMissionDayCheckIn == null ||
            identical(
                typeHabitMissionDayCheckIn, this.typeHabitMissionDayCheckIn)) &&
        (typeHabitGoal == null ||
            identical(typeHabitGoal, this.typeHabitGoal)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (isTrashed == null || identical(isTrashed, this.isTrashed)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt))) {
      return this;
    }

    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      images: images ?? this.images,
      isSaveDiary: isSaveDiary ?? this.isSaveDiary,
      remind: remind ?? this.remind,
      motivation: motivation ?? this.motivation,
      missionDayUnit: missionDayUnit ?? this.missionDayUnit,
      missionDayCheckInStep:
          missionDayCheckInStep ?? this.missionDayCheckInStep,
      missionDayTarget: missionDayTarget ?? this.missionDayTarget,
      isFinished: isFinished ?? this.isFinished,
      habitProgress: habitProgress ?? this.habitProgress,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      typeHabitMissionDayCheckIn:
          typeHabitMissionDayCheckIn ?? this.typeHabitMissionDayCheckIn,
      typeHabitGoal: typeHabitGoal ?? this.typeHabitGoal,
      createdAt: createdAt ?? this.createdAt,
      isTrashed: isTrashed ?? this.isTrashed,
      updatedAt: updatedAt ?? this.updatedAt,
      isCreatedOnLocal: isCreatedOnLocal ?? this.isCreatedOnLocal,
    );
  }

  @override
  String toString() {
    return 'Habit{id: $id, name: $name, icon: $icon, images: $images, isSaveDiary: $isSaveDiary, remind: $remind, motivation: $motivation, missionDayUnit: $missionDayUnit, missionDayCheckInStep: $missionDayCheckInStep, missionDayTarget: $missionDayTarget, isFinished: $isFinished, habitProgress: $habitProgress, type: $type, frequency: $frequency, typeHabitMissionDayCheckIn: $typeHabitMissionDayCheckIn, typeHabitGoal: $typeHabitGoal, createdAt: $createdAt, isTrashed: $isTrashed, updatedAt: $updatedAt}';
  }

  factory Habit.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    final jsonRemindList = map['remind'] as List;
    final List<HabitRemind> remindList = [];
    for (final remindJson in jsonRemindList) {
      remindList.add(HabitRemind.fromJson(remindJson as Map<String, dynamic>));
    }

    final jsonProgressList = map['habitProgress'] as List;
    final List<HabitProgressItem> progressList = [];
    for (final progressJson in jsonProgressList) {
      progressList.add(
          HabitProgressItem.fromJson(progressJson as Map<String, dynamic>));
    }

    final habit = Habit(
      id: map['_id'] as String,
      name: map['name'] as String,
      icon: HabitIcon.fromJson(map['icon'] as Map<String, dynamic>),
      images: HabitImage.fromJson(map['images'] as Map<String, dynamic>),
      isSaveDiary: map['isSaveDiary'] as bool,
      remind: remindList,
      motivation:
          HabitMotivation.fromJson(map['motivation'] as Map<String, dynamic>),
      missionDayUnit: isInt(map['missionDayUnit'] as String)
          ? int.parse(map['missionDayUnit'] as String)
          : 0,
      // TODO 0 -> "0"
      // kServerHabitMissionDayUnit[map['missionDayUnit'] as String] ?? ,
      missionDayCheckInStep: map['missionDayCheckInStep'] as int,
      missionDayTarget: map['missionDayTarget'] as int,
      isFinished: map['isFinished'] as bool,
      habitProgress: progressList,
      frequency:
          HabitFrequency.fromJson(map['frequency'] as Map<String, dynamic>),
      typeHabitGoal: map['typeHabitGoal'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );

    int typeGoal = EHabitGoal.reachACertainAmount.index;
    int typeCheckIn = EHabitMissionDayCheckIn.auto.index;
    if (habit.missionDayCheckInStep == 1 && habit.missionDayTarget == 1) {
      typeGoal = EHabitGoal.archiveItAll.index;
    } else {
      if (habit.missionDayCheckInStep == 0) {
        typeCheckIn = EHabitMissionDayCheckIn.manual.index;
      } else {
        typeCheckIn = EHabitMissionDayCheckIn.auto.index;
      }
    }

    return habit.copyWith(
        typeHabitMissionDayCheckIn: typeCheckIn, typeHabitGoal: typeGoal);
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      '_id': id,
      'name': name,
      'icon': icon.toJson(),
      'images': images.toJson(),
      'isSaveDiary': isSaveDiary,
      'remind': remind.map((e) => e.toJson()).toList(),
      'motivation': motivation.toJson(),
      'missionDayUnit': missionDayUnit.toString(),
      'missionDayCheckInStep': missionDayCheckInStep,
      'missionDayTarget': missionDayTarget,
      'isFinished': isFinished,
      'habitProgress': habitProgress.map((e) => e.toMap()).toList(),
      // 'type': type,
      'frequency': frequency.toJson(),
      // 'typeHabitMissionDayCheckIn': typeHabitMissionDayCheckIn,
      // 'typeHabitGoal': typeHabitGoal,
      // 'isTrashed': isTrashed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  @override
  List<Object> get props => [
        id,
        name,
        icon,
        images,
        isSaveDiary,
        remind,
        motivation,
        missionDayUnit,
        missionDayCheckInStep,
        missionDayTarget,
        isFinished,
        habitProgress,
        type,
        frequency,
        typeHabitMissionDayCheckIn,
        createdAt,
        isTrashed,
        updatedAt,
        typeHabitGoal,
        isCreatedOnLocal,
      ];
}
