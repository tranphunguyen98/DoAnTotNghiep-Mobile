// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_task_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RemoteTaskService implements RemoteTaskService {
  _RemoteTaskService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.18:3006/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<TaskListResponse> getTasks(authorization) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/tasks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TaskListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TaskResponse> getTaskDetail(authorization, taskId) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(taskId, 'taskId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('tasks/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TaskResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TaskListResponse> addTask(
      authorization,
      id,
      name,
      dueDate,
      crontabSchedule,
      section,
      projectId,
      labelIds,
      checkList,
      priority) async {
    // ArgumentError.checkNotNull(authorization, 'authorization');
    // ArgumentError.checkNotNull(id, 'id');
    // ArgumentError.checkNotNull(name, 'name');
    // ArgumentError.checkNotNull(dueDate, 'dueDate');
    // ArgumentError.checkNotNull(crontabSchedule, 'crontabSchedule');
    // ArgumentError.checkNotNull(section, 'section');
    // ArgumentError.checkNotNull(projectId, 'projectId');
    // ArgumentError.checkNotNull(labelIds, 'labelIds');
    // ArgumentError.checkNotNull(checkList, 'checkList');
    // ArgumentError.checkNotNull(priority, 'priority');
    // ArgumentError.checkNotNull(files, 'files');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    if (id != null) {
      _data.fields.add(MapEntry('_id', id));
    }
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (dueDate != null) {
      _data.fields.add(MapEntry('dueDate', dueDate));
    }
    if (crontabSchedule != null) {
      _data.fields.add(MapEntry('crontabSchedule', crontabSchedule));
    }
    if (section != null) {
      _data.fields.add(MapEntry('section', section));
    }
    if (projectId != null) {
      _data.fields.add(MapEntry('projectId', projectId));
    }
    if (labelIds != null) {
      _data.fields.add(MapEntry('labelIds', labelIds));
    }
    if (checkList != null) {
      _data.fields.add(MapEntry('checkList', checkList));
    }
    if (priority != null) {
      _data.fields.add(MapEntry('priority', priority.toString()));
    }

    final _result = await _dio.request<Map<String, dynamic>>('/tasks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TaskListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TaskResponse> updateTask(
      authorization,
      taskId,
      name,
      dueDate,
      crontabSchedule,
      section,
      projectId,
      labelIds,
      checkList,
      priority,
      isCompleted,
      completedDate,
      attachmentInfos) async {
    // ArgumentError.checkNotNull(authorization, 'authorization');
    // ArgumentError.checkNotNull(taskId, 'taskId');
    // ArgumentError.checkNotNull(name, 'name');
    // ArgumentError.checkNotNull(dueDate, 'dueDate');
    // ArgumentError.checkNotNull(crontabSchedule, 'crontabSchedule');
    // ArgumentError.checkNotNull(section, 'section');
    // // ArgumentError.checkNotNull(projectId, 'projectId');
    // ArgumentError.checkNotNull(labelIds, 'labelIds');
    // ArgumentError.checkNotNull(checkList, 'checkList');
    // ArgumentError.checkNotNull(priority, 'priority');
    // ArgumentError.checkNotNull(isCompleted, 'isCompleted');
    // ArgumentError.checkNotNull(completedDate, 'completedDate');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (dueDate != null) {
      _data.fields.add(MapEntry('dueDate', dueDate));
    }
    if (crontabSchedule != null) {
      _data.fields.add(MapEntry('crontabSchedule', crontabSchedule));
    }
    if (section != null) {
      _data.fields.add(MapEntry('section', section));
    }
    if (projectId != null) {
      _data.fields.add(MapEntry('projectId', projectId));
    }
    if (labelIds != null) {
      _data.fields.add(MapEntry('labelIds', labelIds));
    }
    if (checkList != null) {
      _data.fields.add(MapEntry('checkList', checkList));
    }
    if (priority != null) {
      _data.fields.add(MapEntry('priority', priority.toString()));
    }
    if (isCompleted != null) {
      _data.fields.add(MapEntry('isCompleted', isCompleted.toString()));
    }
    if (completedDate != null) {
      _data.fields.add(MapEntry('completedDate', completedDate));
    }

    if (attachmentInfos != null) {
      _data.fields.add(MapEntry('attachmentInfos', attachmentInfos));
    }
    // if (files?.isNotEmpty ?? false) {
    //   for (var file in files) {
    //     _data.files.add(MapEntry('files', MultipartFile.fromFileSync(file)));
    //   }
    // }

    final _result = await _dio.request<Map<String, dynamic>>('/tasks/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TaskResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageResponse> deleteTask(authorization, taskId) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(taskId, 'taskId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/tasks/$taskId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProjectListResponse> getProjects(authorization) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/projects',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProjectListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProjectResponse> addProject(authorization, name, color) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(color, 'color');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'name': name, 'color': color};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/projects',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProjectResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LabelListResponse> getLabels(authorization) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/labels',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LabelListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LabelResponse> addLabel(authorization, name, color) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(color, 'color');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'name': name, 'color': color};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/labels',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LabelResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ListSectionResponse> addSection(authorization, projectId, name) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(projectId, 'projectId');
    ArgumentError.checkNotNull(name, 'name');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'name': name};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/projects/$projectId/sections',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ListSectionResponse.fromJson(_result.data);
    return value;
  }
}
