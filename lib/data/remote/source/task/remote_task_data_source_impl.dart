import 'dart:io';

import 'package:dio/dio.dart';
import 'package:totodo/data/data_source/task/remote_task_data_source.dart';
import 'package:totodo/data/local/model/local_task.dart';
import 'package:totodo/data/model/label.dart';
import 'package:totodo/data/model/project.dart';
import 'package:totodo/data/model/section.dart';
import 'package:totodo/data/remote/exception/unauthenticated_exception.dart';
import 'package:totodo/data/remote/source/task/remote_task_service.dart';
import 'package:totodo/utils/util.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final RemoteTaskService _taskService;

  RemoteTaskDataSourceImpl(this._taskService);

  @override
  Future<LocalTask> addTask(String authorization, LocalTask localTask) async {
    try {
      final taskResponse =
          await _taskService.addTask(authorization, localTask.toJson());
      if (taskResponse.succeeded) {
        return taskResponse.tasks.first;
      }
      throw Exception(taskResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<LocalTask> getDetailTask(String authorization, String id) async {
    final response = await _taskService.getTaskDetail(authorization, id);
    return response.task;
  }

  @override
  Future<List<LocalTask>> getAllTask(String authorization) async {
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
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> updateProject(String authorization, Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  @override
  Future<Label> addLabel(String authorization, Label label) async {
    try {
      final labelResponse =
          await _taskService.addLabel(authorization, label.name, label.color);
      if (labelResponse.succeeded) {
        return labelResponse.label;
      }
      throw Exception(labelResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<List<Label>> getLabels(String authorization) async {
    try {
      final labelListResponse = await _taskService.getLabels(authorization);
      if (labelListResponse.succeeded) {
        return labelListResponse.labels;
      }
      throw Exception(labelListResponse.message ?? "Error Dio");
    } on DioError catch (e, stackTrace) {
      log('stacktrace', stackTrace);
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> updateLabel(String authorization, Label label) {
    // TODO: implement updateLabel
    throw UnimplementedError();
  }

  @override
  Future<LocalTask> updateTask(String authorization, LocalTask task) async {
    // log("TaskToJson", task.toJson());
    final response =
        await _taskService.updateTask(authorization, task.id, task.toJson());
    return response.task;
  }

  @override
  Future<Section> addSection(
      String authorization, String projectId, Section section) async {
    try {
      final labelResponse =
          await _taskService.addSection(authorization, projectId, section.name);
      if (labelResponse.succeeded) {
        return labelResponse.sections
            .firstWhere((element) => element.name == section.name);
      }
      throw Exception(labelResponse.message ?? "Error Dio");
    } on DioError catch (e, stacktrace) {
      log('stacktrace', stacktrace);
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.unauthorized) {
        throw UnauthenticatedException(e.response.statusMessage);
      }
      throw Exception(e.response.data["message"] ?? "Error Dio");
    }
  }

  @override
  Future<void> deleteSection(
      String authorization, String projectId, Section section) {
    // TODO: implement deleteSection
    throw UnimplementedError();
  }

  @override
  Future<void> updateSection(
      String authorization, String projectId, Section section) {
    // TODO: implement updateSection
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String authorization, String taskId) {
    return _taskService.deleteTask(authorization, taskId);
  }
}
