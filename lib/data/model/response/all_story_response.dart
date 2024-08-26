import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/model/request/all_story_request.dart';

part 'all_story_response.g.dart';
part 'all_story_response.freezed.dart';

@freezed
class AllStoryResponse with _$AllStoryResponse {
  const factory AllStoryResponse({
    required bool error,
    required String message,
    @JsonKey(name: "listStory") required List<ListStory> listStory,
  }) = _AllStoryResponse;

  factory AllStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AllStoryResponseFromJson(json);
}
