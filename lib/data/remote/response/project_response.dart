import 'package:totodo/data/model/project.dart';
import 'package:totodo/utils/util.dart';

class ProjectResponse {
  final bool succeeded;
  final String message;
  final Project project;

  ProjectResponse({
    this.succeeded,
    this.message,
    this.project,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    log('json', json);
    final result = json['result'] as Map<String, dynamic>;

    return ProjectResponse(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
      project: Project.fromJson(result),
    );
  }

  @override
  String toString() {
    return 'ProjectResponse{succeeded: $succeeded, message: $message, project: $project}';
  }
}
