// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginStoryResponseImpl _$$LoginStoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginStoryResponseImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      loginResult:
          LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginStoryResponseImplToJson(
        _$LoginStoryResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'loginResult': instance.loginResult,
    };
