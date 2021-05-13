import 'package:dio/dio.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/entity/project.dart';
import 'package:totodo/data/entity/task.dart';
import 'package:totodo/data/local/mapper/local_task_mapper.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/remote/task/remote_task_service.dart';
import 'package:totodo/utils/util.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final RemoteTaskService _taskService;

  RemoteTaskDataSourceImpl(this._taskService);

  @override
  Future<LocalTask> addTask(String authorization, Task task) async {
    final localTask = LocalTaskMapper().mapToLocal(task);

    try {
      final taskResponse =
          await _taskService.addTask(authorization, localTask.toJson());
      if (taskResponse.succeeded) {
        return taskResponse.task;
      }
      throw Exception(taskResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<Task> getDetailTask(String authorization, String id) {
    // TODO: implement getDetailTask
    throw UnimplementedError();
  }

  @override
  Future<List<LocalTask>> getAllTask(
    String authorization,
  ) async {
    try {
      final taskListResponse = await _taskService.getTasks(authorization);
      if (taskListResponse.succeeded) {
        return taskListResponse.tasks;
      }
      throw Exception(taskListResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<Project> addProject(String authorization, Project project) async {
    try {
      final projectResponse = await _taskService.addProject(
          authorization, project.name, project.color);
      if (projectResponse.succeeded) {
        return projectResponse.project;
      }
      throw Exception(projectResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<List<Project>> getProjects(String authorization) async {
    try {
      final projectResponse = await _taskService.getProjects(authorization);
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
