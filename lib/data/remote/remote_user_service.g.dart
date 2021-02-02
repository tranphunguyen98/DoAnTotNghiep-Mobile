// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RemoteUserService implements RemoteUserService {
  _RemoteUserService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://10.0.2.2:3006/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<UserResponse> signUp(email, password) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/users/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserResponse> signIn(email, password) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/users/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserResponse.fromJson(_result.data);
    return value;
  }
}
