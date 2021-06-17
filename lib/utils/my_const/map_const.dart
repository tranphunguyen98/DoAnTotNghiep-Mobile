import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:totodo/bloc/diary/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/data/model/habit/habit_motivation.dart';
import 'package:totodo/utils/my_const/asset_const.dart';

const String kKeyHabitTypeLabel = 'label';
const String kKeyHabitTypeId = 'id';
const List<Map<String, dynamic>> kHabitType = [
  {"label": "Thể loại 1", "id": 0},
  {'label': "Thể loại 2", "id": 1},
  {"label": "Thể loại 3", "id": 2},
  {"label": "Thể loại 4", "id": 3}
];

enum EHabitFrequency { daily, weekly, interval }

Map<int, String> kHabitFrequency = {
  EHabitFrequency.daily.index: 'Daily',
  EHabitFrequency.weekly.index: 'Weekly',
  EHabitFrequency.interval.index: 'Interval',
};

Map<int, String> kDateFilterHabit = {
  DiaryState.kFilterDateNoDate: 'All',
  DiaryState.kFilterDateThisWeek: 'This Week',
  DiaryState.kFilterDateThisMonth: 'This Month',
  DiaryState.kFilterDateThisYear: 'This Year',
};

const Map<int, String> kDailyDays = {
  0: 'T2',
  1: 'T3',
  2: 'T4',
  3: 'T5',
  4: 'T6',
  5: 'T7',
  6: 'CN'
};

const Map<int, String> kEnDailyDays = {
  0: MON,
  1: TUE,
  2: WED,
  3: THU,
  4: FRI,
  5: SAT,
  6: SUN,
};

enum EHabitMissionUnit { count, cup, milliliter, minute, hour, kilometer, page }
const Map<int, String> kHabitMissionDayUnit = {
  0: 'Lần',
  1: 'Cốc',
  2: 'Ml',
  3: 'Phút',
  4: 'Giờ',
  5: 'Km',
  6: 'Trang',
};

enum EHabitMissionDayCheckIn { auto, manual, completedAll }
const Map<int, String> kHabitMissionDayCheckIn = {
  0: 'Tự động',
  1: 'Bằng tay',
  2: 'Hoàn thành tất cả',
};

enum EHabitGoal { archiveItAll, reachACertainAmount }
const Map<int, String> kHabitGoalType = {
  0: 'Đạt 1 lần cho tất cả',
  1: 'Đạt đến số lượng nhất định',
};

const List<int> kListWeeklyDays = [1, 2, 3, 4, 5, 6];

const List<String> kListDefaultQuotation = [
  "Dành thời gian cho những điều tốt đẹp",
  "Bạn hoàn toàn có thể làm được điều này",
  "Bây giờ hoặc không bao giờ",
  "Mọi khoảnh khắc đều quan trọng",
  "Giấc mơ sẽ không bao giờ thành hiện thực trừ khi bạn bắt tay vào làm",
  "Làm giỏi hơn nói hay",
  "Cứ liều thử xem",
  "Hãy ưu tiên cho bản thân",
  "Hãy tin vào chính mình",
  "Làm theo những gì bạn cho là đúng, chứ không phải những gì dễ dàng"
];

final List<String> kListIconDefault = [
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
  kIconMeditation,
  kIconPushUp,
];

final List<Habit> kListHabitDefault = [
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: kIconMeditation),
    motivation: HabitMotivation(text: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Hít Đất',
    icon: HabitIcon(iconImage: kIconPushUp),
    motivation: HabitMotivation(text: kListDefaultQuotation[1]),
    type: 2,
  ),
];
