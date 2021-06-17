import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/utils/util.dart';

class TaskResponse {
  final bool succeeded;
  final String message;
  final LocalTask task;

  TaskResponse({
    this.succeeded,
    this.message,
    this.task,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as Map<String, dynamic>;

    return TaskResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      task: LocalTask.fromJson(result),
    );
  }

  @override
  String toString() {
    return 'ProjectResponse{succeeded: $succeeded, message: $message, task: $task}';
  }
}
