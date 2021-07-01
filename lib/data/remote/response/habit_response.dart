import 'package:totodo/data/model/habit/habit.dart';
import 'package:totodo/utils/util.dart';

class HabitResponse {
  final bool succeeded;
  final String message;
  final Habit habit;

  HabitResponse({
    this.succeeded,
    this.message,
    this.habit,
  });

  factory HabitResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as Map<String, dynamic>;

    return HabitResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      habit: Habit.fromJson(result),
    );
  }
}
