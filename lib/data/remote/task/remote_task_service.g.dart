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
    final _result = await _dio.request<Map<String, dynamic>>('projects',
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
}
