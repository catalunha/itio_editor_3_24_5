// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextEditorState {
  StateStatus get status => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  bool get useCustomQuillToolbar => throw _privateConstructorUsedError;

  /// Create a copy of TextEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TextEditorStateCopyWith<TextEditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextEditorStateCopyWith<$Res> {
  factory $TextEditorStateCopyWith(
          TextEditorState value, $Res Function(TextEditorState) then) =
      _$TextEditorStateCopyWithImpl<$Res, TextEditorState>;
  @useResult
  $Res call({StateStatus status, String? text, bool useCustomQuillToolbar});
}

/// @nodoc
class _$TextEditorStateCopyWithImpl<$Res, $Val extends TextEditorState>
    implements $TextEditorStateCopyWith<$Res> {
  _$TextEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TextEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? text = freezed,
    Object? useCustomQuillToolbar = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      useCustomQuillToolbar: null == useCustomQuillToolbar
          ? _value.useCustomQuillToolbar
          : useCustomQuillToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextEditorStateImplCopyWith<$Res>
    implements $TextEditorStateCopyWith<$Res> {
  factory _$$TextEditorStateImplCopyWith(_$TextEditorStateImpl value,
          $Res Function(_$TextEditorStateImpl) then) =
      __$$TextEditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StateStatus status, String? text, bool useCustomQuillToolbar});
}

/// @nodoc
class __$$TextEditorStateImplCopyWithImpl<$Res>
    extends _$TextEditorStateCopyWithImpl<$Res, _$TextEditorStateImpl>
    implements _$$TextEditorStateImplCopyWith<$Res> {
  __$$TextEditorStateImplCopyWithImpl(
      _$TextEditorStateImpl _value, $Res Function(_$TextEditorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TextEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? text = freezed,
    Object? useCustomQuillToolbar = null,
  }) {
    return _then(_$TextEditorStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      useCustomQuillToolbar: null == useCustomQuillToolbar
          ? _value.useCustomQuillToolbar
          : useCustomQuillToolbar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TextEditorStateImpl implements _TextEditorState {
  const _$TextEditorStateImpl(
      {this.status = StateStatus.initial,
      this.text,
      this.useCustomQuillToolbar = false});

  @override
  @JsonKey()
  final StateStatus status;
  @override
  final String? text;
  @override
  @JsonKey()
  final bool useCustomQuillToolbar;

  @override
  String toString() {
    return 'TextEditorState(status: $status, text: $text, useCustomQuillToolbar: $useCustomQuillToolbar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextEditorStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.useCustomQuillToolbar, useCustomQuillToolbar) ||
                other.useCustomQuillToolbar == useCustomQuillToolbar));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, text, useCustomQuillToolbar);

  /// Create a copy of TextEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextEditorStateImplCopyWith<_$TextEditorStateImpl> get copyWith =>
      __$$TextEditorStateImplCopyWithImpl<_$TextEditorStateImpl>(
          this, _$identity);
}

abstract class _TextEditorState implements TextEditorState {
  const factory _TextEditorState(
      {final StateStatus status,
      final String? text,
      final bool useCustomQuillToolbar}) = _$TextEditorStateImpl;

  @override
  StateStatus get status;
  @override
  String? get text;
  @override
  bool get useCustomQuillToolbar;

  /// Create a copy of TextEditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextEditorStateImplCopyWith<_$TextEditorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
