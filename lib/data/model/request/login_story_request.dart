import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_story_request.g.dart';
part 'login_story_request.freezed.dart';

@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    required String userId,
    required String name,
    required String token,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
