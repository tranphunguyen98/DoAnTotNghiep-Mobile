// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_habit_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RemoteHabitService implements RemoteHabitService {
  _RemoteHabitService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.18:3006/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HabitListResponse> getHabits(authorization) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/habits/by-user',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HabitListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HabitResponse> getHabitDetail(authorization, habitId) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(habitId, 'habitId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('habits/$habitId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HabitResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HabitResponse> updateHabit(
      authorization,
      habitId,
      name,
      icon,
      images,
      remind,
      motivation,
      frequency,
      habitProgress,
      missionDayUnit,
      missionDayCheckInStep,
      missionDayTarget,
      isFinished) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(habitId, 'habitId');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(icon, 'icon');
    ArgumentError.checkNotNull(images, 'images');
    ArgumentError.checkNotNull(remind, 'remind');
    ArgumentError.checkNotNull(motivation, 'motivation');
    ArgumentError.checkNotNull(frequency, 'frequency');
    ArgumentError.checkNotNull(habitProgress, 'habitProgress');
    ArgumentError.checkNotNull(missionDayUnit, 'missionDayUnit');
    ArgumentError.checkNotNull(missionDayCheckInStep, 'missionDayCheckInStep');
    ArgumentError.checkNotNull(missionDayTarget, 'missionDayTarget');
    ArgumentError.checkNotNull(isFinished, 'isFinished');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (icon != null) {
      _data.fields.add(MapEntry('icon', icon));
    }
    if (images != null) {
      _data.fields.add(MapEntry('images', images));
    }
    if (remind != null) {
      _data.fields.add(MapEntry('remind', remind));
    }
    if (motivation != null) {
      _data.fields.add(MapEntry('motivation', motivation));
    }
    if (frequency != null) {
      _data.fields.add(MapEntry('frequency', frequency));
    }
    if (habitProgress != null) {
      _data.fields.add(MapEntry('habitProgress', habitProgress));
    }
    if (missionDayUnit != null) {
      _data.fields.add(MapEntry('missionDayUnit', missionDayUnit.toString()));
    }
    if (missionDayCheckInStep != null) {
      _data.fields.add(
          MapEntry('missionDayCheckInStep', missionDayCheckInStep.toString()));
    }
    if (missionDayTarget != null) {
      _data.fields
          .add(MapEntry('missionDayTarget', missionDayTarget.toString()));
    }
    if (isFinished != null) {
      _data.fields.add(MapEntry('isFinished', isFinished.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('habits/$habitId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PATCH',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HabitResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<HabitResponse> addHabit(
      authorization,
      id,
      name,
      icon,
      images,
      remind,
      motivation,
      frequency,
      missionDayUnit,
      missionDayCheckInStep,
      missionDayTarget) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(icon, 'icon');
    ArgumentError.checkNotNull(images, 'images');
    ArgumentError.checkNotNull(remind, 'remind');
    ArgumentError.checkNotNull(motivation, 'motivation');
    ArgumentError.checkNotNull(frequency, 'frequency');
    ArgumentError.checkNotNull(missionDayUnit, 'missionDayUnit');
    ArgumentError.checkNotNull(missionDayCheckInStep, 'missionDayCheckInStep');
    ArgumentError.checkNotNull(missionDayTarget, 'missionDayTarget');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    if (id != null) {
      _data.fields.add(MapEntry('_id', id));
    }
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (icon != null) {
      _data.fields.add(MapEntry('icon', icon));
    }
    if (images != null) {
      _data.fields.add(MapEntry('images', images));
    }
    if (remind != null) {
      _data.fields.add(MapEntry('remind', remind));
    }
    if (motivation != null) {
      _data.fields.add(MapEntry('motivation', motivation));
    }
    if (frequency != null) {
      _data.fields.add(MapEntry('frequency', frequency));
    }
    if (missionDayUnit != null) {
      _data.fields.add(MapEntry('missionDayUnit', missionDayUnit.toString()));
    }
    if (missionDayCheckInStep != null) {
      _data.fields.add(
          MapEntry('missionDayCheckInStep', missionDayCheckInStep.toString()));
    }
    if (missionDayTarget != null) {
      _data.fields
          .add(MapEntry('missionDayTarget', missionDayTarget.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('/habits',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = HabitResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageResponse> addDiary(
      authorization, habitId, text, feeling, time) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(habitId, 'habitId');
    ArgumentError.checkNotNull(text, 'text');
    ArgumentError.checkNotNull(feeling, 'feeling');
    ArgumentError.checkNotNull(time, 'time');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    if (text != null) {
      _data.fields.add(MapEntry('text', text));
    }
    if (feeling != null) {
      _data.fields.add(MapEntry('feeling', feeling.toString()));
    }
    if (time != null) {
      _data.fields.add(MapEntry('time', time));
    }
    final _result = await _dio.request<Map<String, dynamic>>(
        '/habits/$habitId/add-diary',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MessageResponseRegister> deleteHabit(authorization, habitId) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(habitId, 'habitId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/habits/$habitId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MessageResponseRegister.fromJson(_result.data);
    return value;
  }

  @override
  Future<DiaryListResponse> getDiaryByHabitId(authorization, habitId) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    ArgumentError.checkNotNull(habitId, 'habitId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/habits/$habitId/diaries',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'authorization': authorization},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DiaryListResponse.fromJson(_result.data);
    return value;
  }
}
