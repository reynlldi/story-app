// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterStoryResponse _$RegisterStoryResponseFromJson(
    Map<String, dynamic> json) {
  return _RegisterStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$RegisterStoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegisterStoryResponseCopyWith<RegisterStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStoryResponseCopyWith<$Res> {
  factory $RegisterStoryResponseCopyWith(RegisterStoryResponse value,
          $Res Function(RegisterStoryResponse) then) =
      _$RegisterStoryResponseCopyWithImpl<$Res, RegisterStoryResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$RegisterStoryResponseCopyWithImpl<$Res,
        $Val extends RegisterStoryResponse>
    implements $RegisterStoryResponseCopyWith<$Res> {
  _$RegisterStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterStoryResponseImplCopyWith<$Res>
    implements $RegisterStoryResponseCopyWith<$Res> {
  factory _$$RegisterStoryResponseImplCopyWith(
          _$RegisterStoryResponseImpl value,
          $Res Function(_$RegisterStoryResponseImpl) then) =
      __$$RegisterStoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$RegisterStoryResponseImplCopyWithImpl<$Res>
    extends _$RegisterStoryResponseCopyWithImpl<$Res,
        _$RegisterStoryResponseImpl>
    implements _$$RegisterStoryResponseImplCopyWith<$Res> {
  __$$RegisterStoryResponseImplCopyWithImpl(_$RegisterStoryResponseImpl _value,
      $Res Function(_$RegisterStoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$RegisterStoryResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterStoryResponseImpl implements _RegisterStoryResponse {
  const _$RegisterStoryResponseImpl(
      {required this.error, required this.message});

  factory _$RegisterStoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterStoryResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'RegisterStoryResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStoryResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterStoryResponseImplCopyWith<_$RegisterStoryResponseImpl>
      get copyWith => __$$RegisterStoryResponseImplCopyWithImpl<
          _$RegisterStoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterStoryResponseImplToJson(
      this,
    );
  }
}

abstract class _RegisterStoryResponse implements RegisterStoryResponse {
  const factory _RegisterStoryResponse(
      {required final bool error,
      required final String message}) = _$RegisterStoryResponseImpl;

  factory _RegisterStoryResponse.fromJson(Map<String, dynamic> json) =
      _$RegisterStoryResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$RegisterStoryResponseImplCopyWith<_$RegisterStoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
