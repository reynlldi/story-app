import 'package:freezed_annotation/freezed_annotation.dart';
part 'all_story_request.g.dart';
part 'all_story_request.freezed.dart';

@freezed
class ListStory with _$ListStory {
  const factory ListStory({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _ListStory;

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);
}
