import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/utils/util.dart';

class TaskListResponse {
  final bool succeeded;
  final String message;
  final List<LocalTask> tasks;

  TaskListResponse({
    this.succeeded,
    this.message,
    this.tasks,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as List;

    return TaskListResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      tasks: result
          .map((task) => LocalTask.fromJson(task as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ProjectResponse{succeeded: $succeeded, message: $message, tasks: $tasks}';
  }
}
