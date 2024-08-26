import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_story_request.g.dart';
part 'detail_story_request.freezed.dart';

@freezed
class DetailStory with _$DetailStory {
  const factory DetailStory({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _DetailStory;

  factory DetailStory.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryFromJson(json);
}
