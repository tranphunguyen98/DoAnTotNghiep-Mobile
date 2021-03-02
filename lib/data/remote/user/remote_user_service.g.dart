// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RemoteUserService implements RemoteUserService {
  _RemoteUserService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.7:3006/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<MessageResponseRegister> signUp(displayName, email, password) async {
    ArgumentError.checkNotNull(displayName, 'displayName');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'displayName': displayName,
      'email': email,
      'password': password
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/users/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponseRegister.fromJson(_result.data);
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

  @override
  Future<MessageResponseRegister> resetPassword(
      email, otpCode, newPassword) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(otpCode, 'otpCode');
    ArgumentError.checkNotNull(newPassword, 'newPassword');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'email': email,
      'otpCode': otpCode,
      'newPassword': newPassword
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/users/reset-password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponseRegister.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageResponseRegister> sendOTPResetPassword(email) async {
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/users/reset-password/request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponseRegister.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageResponse> changePassword(oldPassword, newPassword) async {
    ArgumentError.checkNotNull(oldPassword, 'oldPassword');
    ArgumentError.checkNotNull(newPassword, 'newPassword');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'oldPassword': oldPassword, 'newPassword': newPassword};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/users/change_password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponse.fromJson(_result.data);
    return value;
  }
}
