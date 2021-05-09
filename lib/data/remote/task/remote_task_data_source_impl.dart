import 'package:dio/dio.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/remote/task/remote_task_service.dart';
import 'package:totodo/utils/util.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final RemoteTaskService _taskService;

  RemoteTaskDataSourceImpl(this._taskService);

  @override
  Future<bool> addTask(String authorization, Task task) {
    // TODO: implement getDetailTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getDetailTask(String authorization, String id) {
    // TODO: implement getDetailTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask(
    String authorization,
  ) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return [];
    });
  }

  @override
  Future<void> addProject(String authorization, Project project) {
    // TODO: implement addProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects(String authorization) async {
    try {
      final projectResponse = await _taskService.getProjects(authorization);
      log('projects', projectResponse);

      if (projectResponse.succeeded) {
        return projectResponse.projects;
      }
      throw Exception(projectResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> updateProject(String authorization, Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
