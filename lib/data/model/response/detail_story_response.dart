import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/model/request/detail_story_request.dart';
part 'detail_story_response.g.dart';
part 'detail_story_response.freezed.dart';

@freezed
class DetailStoryResponse with _$DetailStoryResponse {
  const factory DetailStoryResponse({
    required bool error,
    required String message,
    @JsonKey(name: "story") required DetailStory detailStory,
  }) = _DetailStoryResponse;

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseFromJson(json);
}
