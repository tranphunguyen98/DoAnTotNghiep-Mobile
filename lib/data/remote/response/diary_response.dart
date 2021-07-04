import 'package:totodo/data/model/habit/diary_item.dart';
import 'package:totodo/utils/util.dart';

class DiaryResponse {
  final bool succeeded;
  final String message;
  final Diary diary;

  DiaryResponse({
    this.succeeded,
    this.message,
    this.diary,
  });

  factory DiaryResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as Map<String, dynamic>;

    return DiaryResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      diary: Diary.fromJson(result),
    );
  }
}
