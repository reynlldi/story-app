// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllStoryResponseImpl _$$AllStoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AllStoryResponseImpl(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => ListStory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AllStoryResponseImplToJson(
        _$AllStoryResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
