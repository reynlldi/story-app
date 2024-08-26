// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllStoryResponse _$AllStoryResponseFromJson(Map<String, dynamic> json) {
  return _AllStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$AllStoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: "listStory")
  List<ListStory> get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllStoryResponseCopyWith<AllStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllStoryResponseCopyWith<$Res> {
  factory $AllStoryResponseCopyWith(
          AllStoryResponse value, $Res Function(AllStoryResponse) then) =
      _$AllStoryResponseCopyWithImpl<$Res, AllStoryResponse>;
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "listStory") List<ListStory> listStory});
}

/// @nodoc
class _$AllStoryResponseCopyWithImpl<$Res, $Val extends AllStoryResponse>
    implements $AllStoryResponseCopyWith<$Res> {
  _$AllStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllStoryResponseImplCopyWith<$Res>
    implements $AllStoryResponseCopyWith<$Res> {
  factory _$$AllStoryResponseImplCopyWith(_$AllStoryResponseImpl value,
          $Res Function(_$AllStoryResponseImpl) then) =
      __$$AllStoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "listStory") List<ListStory> listStory});
}

/// @nodoc
class __$$AllStoryResponseImplCopyWithImpl<$Res>
    extends _$AllStoryResponseCopyWithImpl<$Res, _$AllStoryResponseImpl>
    implements _$$AllStoryResponseImplCopyWith<$Res> {
  __$$AllStoryResponseImplCopyWithImpl(_$AllStoryResponseImpl _value,
      $Res Function(_$AllStoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_$AllStoryResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllStoryResponseImpl implements _AllStoryResponse {
  const _$AllStoryResponseImpl(
      {required this.error,
      required this.message,
      @JsonKey(name: "listStory") required final List<ListStory> listStory})
      : _listStory = listStory;

  factory _$AllStoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllStoryResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<ListStory> _listStory;
  @override
  @JsonKey(name: "listStory")
  List<ListStory> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'AllStoryResponse(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllStoryResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllStoryResponseImplCopyWith<_$AllStoryResponseImpl> get copyWith =>
      __$$AllStoryResponseImplCopyWithImpl<_$AllStoryResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllStoryResponseImplToJson(
      this,
    );
  }
}

abstract class _AllStoryResponse implements AllStoryResponse {
  const factory _AllStoryResponse(
      {required final bool error,
      required final String message,
      @JsonKey(name: "listStory")
      required final List<ListStory> listStory}) = _$AllStoryResponseImpl;

  factory _AllStoryResponse.fromJson(Map<String, dynamic> json) =
      _$AllStoryResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(name: "listStory")
  List<ListStory> get listStory;
  @override
  @JsonKey(ignore: true)
  _$$AllStoryResponseImplCopyWith<_$AllStoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
