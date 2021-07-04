import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:totodo/bloc/diary/bloc.dart';
import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/data/model/habit/habit_icon.dart';
import 'package:totodo/data/model/habit/habit_motivation.dart';

const String kKeyHabitTypeLabel = 'label';
const String kKeyHabitTypeId = 'id';
// const List<Map<String, dynamic>> kHabitType = [
//   {"label": "Thể loại 1", "id": 0},
//   {'label': "Thể loại 2", "id": 1},
//   {"label": "Thể loại 3", "id": 2},
//   {"label": "Thể loại 4", "id": 3}
// ];

enum EHabitFrequency { daily, weekly, interval }

Map<int, String> kHabitFrequency = {
  EHabitFrequency.daily.index: 'Daily',
  EHabitFrequency.weekly.index: 'Weekly',
  // EHabitFrequency.interval.index: 'Interval',
};

Map<int, String> kServerHabitFrequency = {
  EHabitFrequency.daily.index: 'daily',
  EHabitFrequency.weekly.index: 'weekly',
  // EHabitFrequency.interval.index: 'Interval',
};

Map<int, String> kDateFilterHabit = {
  DiaryState.kFilterDateNoDate: 'Tất cả',
  DiaryState.kFilterDateThisWeek: 'Tuần này',
  DiaryState.kFilterDateThisMonth: 'Tháng này',
  DiaryState.kFilterDateThisYear: 'Năm nay',
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
  2: 'ML',
  3: 'Phút',
  4: 'Giờ',
  5: 'Km',
  6: 'Trang',
};

const Map<String, int> kServerHabitMissionDayUnit = {
  'Lần': 0,
  'Cốc': 1,
  'ML': 2,
  'Phút': 3,
  'Giờ': 4,
  'Km': 5,
  'Trang': 6,
};

enum EHabitMissionDayCheckIn { auto, manual }

const Map<int, String> kHabitMissionDayCheckIn = {0: 'Tự động', 1: 'Bằng tay'};

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

// final List<String> kListIconDefault = List.generate(57, (index) => index + 1)
//     .map((index) => getAssetIcon(index))
//     .toList();
final Map<int, String> kCheckInColor = {
  1: "#3FA9F5",
  2: "#3FA9F5",
  3: "#8CC63F",
  4: "#EF7B7B",
  5: "#CE9800",
  6: "#0071BC",
  7: "#006837",
  8: "#3FA9F5",
  9: "#993A61",
  10: "#B76F20",
  11: "#687A82",
  12: "#7E40B5",
  13: "#1B1464",
  14: "#969132",
  15: "#0071BC",
  16: "#0071BC",
  17: "#A67C52",
  18: "#F15A24",
  19: "#009245",
  20: "#827F80",
  21: "#F9BD6E",
  22: "#7D71F4",
  23: "#05527C",
  24: "#9B5C78",
  25: "#5056A3",
  26: "#739392",
  27: "#614793",
  28: "#DD6333",
  29: "#124860",
  30: "#97D169",
  31: "#61ADA2",
  32: "#7A7A7A",
  33: "#966977",
  34: "#487525",
  35: "#0071BC",
  36: "#D15A66",
  37: "#795996",
  38: "#351F1F",
  39: "#593B7F",
  40: "#7C4253",
  41: "#C14F5D",
  42: "#EA6F49",
  43: "#E07514",
  44: "#39B54A",
  45: "#E83D3D",
  46: "#53C5D0",
  47: "#53840D",
  48: "#5252EF",
  49: "#9E846D",
  50: "#009245",
  51: "#CE6655",
  52: "#7596CC",
  53: "#823737",
  54: "#59879B",
  55: "#5B9975",
  56: "#2C631A",
  57: "#629AF4",
  58: "#3C5666",
  59: "#662D91",
  60: "#45377A",
  61: "#2B136D",
  62: "#5768FF",
  63: "#7C4253",
  64: "#00989D",
  65: "#00989D",
  66: "#6A90CC",
  67: "#385D7F",
  68: "#934C69",
  69: "#45377A",
  70: "#61ADA2",
  71: "#1957C2",
  72: "#105066",
  73: "#7C7F7D",
  74: "#E83D3D",
  75: "#6BA6C9",
  76: "#72BF44",
  77: "#5E4E72",
  78: "#FF9161",
};

final List<Habit> kListHabitDefault = [
  Habit(
    name: 'Thiền',
    icon: HabitIcon(iconImage: "27"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Nhảy dây',
    icon: HabitIcon(iconImage: "25"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Đọc sách',
    icon: HabitIcon(iconImage: "52"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Đạp xe',
    icon: HabitIcon(iconImage: "14"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Đi bộ',
    icon: HabitIcon(iconImage: "22"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Tập yoga',
    icon: HabitIcon(iconImage: "31"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Không uống bia',
    icon: HabitIcon(iconImage: "19"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Không hút thuốc',
    icon: HabitIcon(iconImage: "18"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
  Habit(
    name: 'Ngủ đúng giờ',
    icon: HabitIcon(iconImage: "21"),
    motivation: HabitMotivation(content: kListDefaultQuotation[0]),
    type: 1,
  ),
];
