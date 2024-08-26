import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/model/request/login_story_request.dart';

part 'login_story_response.g.dart';
part 'login_story_response.freezed.dart';

@freezed
class LoginStoryResponse with _$LoginStoryResponse {
  const factory LoginStoryResponse({
    required bool error,
    required String message,
    @JsonKey(name: "loginResult") required LoginResult loginResult,
  }) = _LoginStoryResponse;

  factory LoginStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginStoryResponseFromJson(json);
}
