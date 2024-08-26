import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_story_response.g.dart';
part 'register_story_response.freezed.dart';

@freezed
class RegisterStoryResponse with _$RegisterStoryResponse {
  const factory RegisterStoryResponse({
    required bool error,
    required String message,
  }) = _RegisterStoryResponse;

  factory RegisterStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterStoryResponseFromJson(json);
}
