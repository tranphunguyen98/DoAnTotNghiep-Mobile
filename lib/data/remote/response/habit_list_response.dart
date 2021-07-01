import 'package:totodo/data/model/habit/habit.dart';

class HabitListResponse {
  final bool succeeded;
  final String message;
  final List<Habit> habits;

  HabitListResponse({
    this.succeeded,
    this.message,
    this.habits,
  });

  factory HabitListResponse.fromJson(Map<String, dynamic> json) {
    // log('json', json);
    final result = json['result'] as List;

    return HabitListResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      habits: result.map((habit) {
        return Habit.fromJson(habit['habit'] as Map<String, dynamic>);
      }).toList(),
    );
  }

  @override
  String toString() {
    return 'HabitListResponse{succeeded: $succeeded, message: $message, tasks: $habits}';
  }
}
