// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_task_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RemoteTaskService implements RemoteTaskService {
  _RemoteTaskService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://personal-task-management-be.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ProjectResponse> getProjects(authorization) async {
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
    log('_result', _result);
    final value = ProjectResponse.fromJson(_result.data);
    return value;
  }
}
