import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:totodo/data/entity/habit/habit_frequency.dart';
import 'package:totodo/data/entity/habit/habit_image.dart';
import 'package:totodo/data/entity/habit/habit_motivation.dart';
import 'package:totodo/data/entity/habit/habit_progress_item.dart';
import 'package:totodo/data/entity/habit/habit_remind.dart';
import 'package:totodo/utils/my_const/hive_const.dart';
import 'package:totodo/utils/my_const/my_const.dart';

import 'habit_icon.dart';

part 'habit.g.dart';

@HiveType(typeId: kHiveTypeHabit)
class Habit extends Equatable {
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
  final List<HabitRemind> reminds;
  @HiveField(6)
  final HabitMotivation motivation;
  @HiveField(7)
  final int missionDayUnit;
  @HiveField(8)
  final int missionDayCheckInStep;
  @HiveField(9)
  final int totalDayAmount;
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

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  Habit(
      {this.id,
      this.name,
      this.icon,
      this.images,
      this.isSaveDiary = true,
      this.motivation = const HabitMotivation(text: ''),
      this.missionDayUnit = 0, // 0: Count
      this.missionDayCheckInStep = 1,
      this.totalDayAmount = 1,
      this.typeHabitMissionDayCheckIn = 0, // 0: Auto
      this.typeHabitGoal = 0, //0: completeAll
      this.isFinished = false,
      this.habitProgress,
      this.type = 0,
      List<HabitRemind> reminds,
      HabitFrequency frequency})
      : frequency = frequency ??
            HabitFrequency(
              typeFrequency: EHabitFrequency.daily.index,
              dailyDays: kDailyDays.keys.toList(),
              intervalDays: 2,
              weeklyDays: 1,
            ),
        reminds = reminds ?? <HabitRemind>[];

  Habit copyWith({
    String id,
    String name,
    HabitIcon icon,
    HabitImage images,
    bool isSaveDiary,
    List<HabitRemind> reminds,
    HabitMotivation motivation,
    int missionDayUnit,
    int missionDayCheckInStep,
    int totalDayAmount,
    bool isFinished,
    List<HabitProgressItem> habitProgress,
    int type,
    HabitFrequency frequency,
    int typeHabitMissionDayCheckIn,
    int typeHabitGoal,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (icon == null || identical(icon, this.icon)) &&
        (images == null || identical(images, this.images)) &&
        (isSaveDiary == null || identical(isSaveDiary, this.isSaveDiary)) &&
        (reminds == null || identical(reminds, this.reminds)) &&
        (motivation == null || identical(motivation, this.motivation)) &&
        (missionDayUnit == null ||
            identical(missionDayUnit, this.missionDayUnit)) &&
        (missionDayCheckInStep == null ||
            identical(missionDayCheckInStep, this.missionDayCheckInStep)) &&
        (totalDayAmount == null ||
            identical(totalDayAmount, this.totalDayAmount)) &&
        (isFinished == null || identical(isFinished, this.isFinished)) &&
        (habitProgress == null ||
            identical(habitProgress, this.habitProgress)) &&
        (type == null || identical(type, this.type)) &&
        (frequency == null || identical(frequency, this.frequency)) &&
        (typeHabitMissionDayCheckIn == null ||
            identical(
                typeHabitMissionDayCheckIn, this.typeHabitMissionDayCheckIn)) &&
        (typeHabitGoal == null ||
            identical(typeHabitGoal, this.typeHabitGoal))) {
      return this;
    }

    return new Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      images: images ?? this.images,
      isSaveDiary: isSaveDiary ?? this.isSaveDiary,
      reminds: reminds ?? this.reminds,
      motivation: motivation ?? this.motivation,
      missionDayUnit: missionDayUnit ?? this.missionDayUnit,
      missionDayCheckInStep:
          missionDayCheckInStep ?? this.missionDayCheckInStep,
      totalDayAmount: totalDayAmount ?? this.totalDayAmount,
      isFinished: isFinished ?? this.isFinished,
      habitProgress: habitProgress ?? this.habitProgress,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      typeHabitMissionDayCheckIn:
          typeHabitMissionDayCheckIn ?? this.typeHabitMissionDayCheckIn,
      typeHabitGoal: typeHabitGoal ?? this.typeHabitGoal,
    );
  }

  @override
  String toString() {
    return 'Habit{id: $id, name: $name, icon: $icon, images: $images, isSaveDiary: $isSaveDiary, reminds: $reminds, motivation: $motivation, missionDayUnit: $missionDayUnit, missionDayCheckInStep: $missionDayCheckInStep, totalDayAmount: $totalDayAmount, isFinished: $isFinished, habitProgress: $habitProgress, type: $type, frequency: $frequency, typeHabitMissionDayCheckIn: $typeHabitMissionDayCheckIn, typeHabitGoal: $typeHabitGoal}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          images == other.images &&
          isSaveDiary == other.isSaveDiary &&
          reminds == other.reminds &&
          motivation == other.motivation &&
          missionDayUnit == other.missionDayUnit &&
          missionDayCheckInStep == other.missionDayCheckInStep &&
          totalDayAmount == other.totalDayAmount &&
          isFinished == other.isFinished &&
          habitProgress == other.habitProgress &&
          type == other.type &&
          frequency == other.frequency &&
          typeHabitMissionDayCheckIn == other.typeHabitMissionDayCheckIn &&
          typeHabitGoal == other.typeHabitGoal);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      images.hashCode ^
      isSaveDiary.hashCode ^
      reminds.hashCode ^
      motivation.hashCode ^
      missionDayUnit.hashCode ^
      missionDayCheckInStep.hashCode ^
      totalDayAmount.hashCode ^
      isFinished.hashCode ^
      habitProgress.hashCode ^
      type.hashCode ^
      frequency.hashCode ^
      typeHabitMissionDayCheckIn.hashCode ^
      typeHabitGoal.hashCode;

  factory Habit.fromMap(Map<String, dynamic> map) {
    return new Habit(
      id: map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as HabitIcon,
      images: map['images'] as HabitImage,
      isSaveDiary: map['isSaveDiary'] as bool,
      reminds: map['reminds'] as List<HabitRemind>,
      motivation: map['motivation'] as HabitMotivation,
      missionDayUnit: map['missionDayUnit'] as int,
      missionDayCheckInStep: map['missionDayCheckInStep'] as int,
      totalDayAmount: map['totalDayAmount'] as int,
      isFinished: map['isFinished'] as bool,
      habitProgress: map['habitProgress'] as List<HabitProgressItem>,
      type: map['type'] as int,
      frequency: map['frequency'] as HabitFrequency,
      typeHabitMissionDayCheckIn: map['typeHabitMissionDayCheckIn'] as int,
      typeHabitGoal: map['typeHabitGoal'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'icon': this.icon,
      'images': this.images,
      'isSaveDiary': this.isSaveDiary,
      'reminds': this.reminds,
      'motivation': this.motivation,
      'missionDayUnit': this.missionDayUnit,
      'missionDayCheckInStep': this.missionDayCheckInStep,
      'totalDayAmount': this.totalDayAmount,
      'isFinished': this.isFinished,
      'habitProgress': this.habitProgress,
      'type': this.type,
      'frequency': this.frequency,
      'typeHabitMissionDayCheckIn': this.typeHabitMissionDayCheckIn,
      'typeHabitGoal': this.typeHabitGoal,
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
        reminds,
        motivation,
        missionDayUnit,
        missionDayCheckInStep,
        totalDayAmount,
        isFinished,
        habitProgress,
        type,
        frequency,
        typeHabitMissionDayCheckIn,
      ];
}
