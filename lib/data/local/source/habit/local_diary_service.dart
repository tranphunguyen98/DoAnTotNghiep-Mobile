import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:objectid/objectid.dart';
import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/utils/util.dart';

@Injectable()
class LocalDiaryService {
  static const kNameBoxDiary = "diary";

  Box _diaryBox;

  LocalDiaryService() {
    _diaryBox = Hive.box(kNameBoxDiary);
  }

  Future<bool> addDiary(Diary diary) async {
    if (diary.id == null) {
      _diaryBox.add(diary.copyWith(id: ObjectId().hexString));
    } else {
      _diaryBox.add(diary);
    }
    return true;
  }

  Future<List<Diary>> getAllDiary() async {
    final listDiary = <Diary>[];
    // _habitBoxDiary.clear();
    for (var i = 0; i < _diaryBox.length; i++) {
      listDiary.add(_diaryBox.getAt(i) as Diary);
    }

    log("LIST DIARY: ${listDiary.length}");
    return listDiary ?? <Diary>[];
  }

  // Future<Diary> getDiaryFromId(String idDiary) async {
  //   final habit = await _habitBoxDiary.values
  //       .firstWhere((element) => (element as Diary).id == idDiary) as Diary;
  //
  //   return habit;
  // }

  Future<List<Diary>> getDiaryFromHabitId(String habitId) async {
    final a = await getAllDiary();
    final diaries = _diaryBox.values
        .where((element) => (element as Diary).habit == habitId)
        .map((e) => e as Diary)
        .toList();
    return diaries;
  }

  Future<bool> updateDiary(Diary habit) async {
    int indexUpdated = -1;

    for (var i = 0; i < _diaryBox.length; i++) {
      if ((_diaryBox.getAt(i) as Diary).id == habit.id) {
        indexUpdated = i;
        break;
      }
    }
    if (indexUpdated > -1) {
      _diaryBox.putAt(indexUpdated, habit);
      return true;
    }
    return false;
  }

  Future<void> saveDiaries(List<Diary> diaries) async {
    _diaryBox.clear();
    _diaryBox.addAll(diaries);
  }

  Future<void> clearData() async {
    _diaryBox.clear();
  }
}
