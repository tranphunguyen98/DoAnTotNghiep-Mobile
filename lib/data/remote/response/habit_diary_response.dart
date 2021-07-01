import 'package:totodo/data/model/habit/diary_item.dart';

class DiaryListResponse {
  final bool succeeded;
  final String message;
  final List<Diary> diaries;

  DiaryListResponse({
    this.succeeded,
    this.message,
    this.diaries,
  });

  factory DiaryListResponse.fromJson(Map<String, dynamic> json) {
    // log('json', json);
    final result = json['result'] as List;

    return DiaryListResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      diaries: result.map((diary) {
        return Diary.fromJson(diary as Map<String, dynamic>);
      }).toList(),
    );
  }

  @override
  String toString() {
    return 'HabitListResponse{succeeded: $succeeded, message: $message, tasks: $diaries}';
  }
}
