import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/state_utilities.dart';
part 'text_editor_state.freezed.dart';

// dart run build_runner build -d --build-filter="lib/editor/**.dart"

@freezed
abstract class TextEditorState with _$TextEditorState {
  const factory TextEditorState({
    @Default(StateStatus.initial) StateStatus status,
    String? text,
    @Default(false) bool useCustomQuillToolbar,
  }) = _TextEditorState;
}
