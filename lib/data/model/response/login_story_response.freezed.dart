// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_story_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginStoryResponse _$LoginStoryResponseFromJson(Map<String, dynamic> json) {
  return _LoginStoryResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginStoryResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: "loginResult")
  LoginResult get loginResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginStoryResponseCopyWith<LoginStoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStoryResponseCopyWith<$Res> {
  factory $LoginStoryResponseCopyWith(
          LoginStoryResponse value, $Res Function(LoginStoryResponse) then) =
      _$LoginStoryResponseCopyWithImpl<$Res, LoginStoryResponse>;
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "loginResult") LoginResult loginResult});

  $LoginResultCopyWith<$Res> get loginResult;
}

/// @nodoc
class _$LoginStoryResponseCopyWithImpl<$Res, $Val extends LoginStoryResponse>
    implements $LoginStoryResponseCopyWith<$Res> {
  _$LoginStoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = null,
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
      loginResult: null == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as LoginResult,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LoginResultCopyWith<$Res> get loginResult {
    return $LoginResultCopyWith<$Res>(_value.loginResult, (value) {
      return _then(_value.copyWith(loginResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginStoryResponseImplCopyWith<$Res>
    implements $LoginStoryResponseCopyWith<$Res> {
  factory _$$LoginStoryResponseImplCopyWith(_$LoginStoryResponseImpl value,
          $Res Function(_$LoginStoryResponseImpl) then) =
      __$$LoginStoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "loginResult") LoginResult loginResult});

  @override
  $LoginResultCopyWith<$Res> get loginResult;
}

/// @nodoc
class __$$LoginStoryResponseImplCopyWithImpl<$Res>
    extends _$LoginStoryResponseCopyWithImpl<$Res, _$LoginStoryResponseImpl>
    implements _$$LoginStoryResponseImplCopyWith<$Res> {
  __$$LoginStoryResponseImplCopyWithImpl(_$LoginStoryResponseImpl _value,
      $Res Function(_$LoginStoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? loginResult = null,
  }) {
    return _then(_$LoginStoryResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      loginResult: null == loginResult
          ? _value.loginResult
          : loginResult // ignore: cast_nullable_to_non_nullable
              as LoginResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginStoryResponseImpl implements _LoginStoryResponse {
  const _$LoginStoryResponseImpl(
      {required this.error,
      required this.message,
      @JsonKey(name: "loginResult") required this.loginResult});

  factory _$LoginStoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginStoryResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  @JsonKey(name: "loginResult")
  final LoginResult loginResult;

  @override
  String toString() {
    return 'LoginStoryResponse(error: $error, message: $message, loginResult: $loginResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStoryResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.loginResult, loginResult) ||
                other.loginResult == loginResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, loginResult);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStoryResponseImplCopyWith<_$LoginStoryResponseImpl> get copyWith =>
      __$$LoginStoryResponseImplCopyWithImpl<_$LoginStoryResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginStoryResponseImplToJson(
      this,
    );
  }
}

abstract class _LoginStoryResponse implements LoginStoryResponse {
  const factory _LoginStoryResponse(
      {required final bool error,
      required final String message,
      @JsonKey(name: "loginResult")
      required final LoginResult loginResult}) = _$LoginStoryResponseImpl;

  factory _LoginStoryResponse.fromJson(Map<String, dynamic> json) =
      _$LoginStoryResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(name: "loginResult")
  LoginResult get loginResult;
  @override
  @JsonKey(ignore: true)
  _$$LoginStoryResponseImplCopyWith<_$LoginStoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
