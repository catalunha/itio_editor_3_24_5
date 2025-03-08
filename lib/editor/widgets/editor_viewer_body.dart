import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import 'package:itio_editor/editor/widgets/editor_writer_body.dart';

import '../cubit/text_editor_cubit.dart';

import 'my_quill_editor.dart';

class EditorViewerBody extends StatefulWidget {
  const EditorViewerBody({super.key});

  @override
  State<EditorViewerBody> createState() => _EditorViewerBodyState();
}

class _EditorViewerBodyState extends State<EditorViewerBody> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      final String guideContent =
          context.read<TextEditorCubit>().state.text ?? '';
      final json = jsonDecode(guideContent);

      _controller.document = Document.fromJson(json);
    } catch (_) {}

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Builder(
        builder: (context) {
          return Expanded(
            child: MyQuillEditor(
              controller: _controller,
              configurations: QuillEditorConfigurations(
                characterShortcutEvents: standardCharactersShortcutEvents,
                spaceShortcutEvents: standardSpaceShorcutEvents,
                searchConfigurations: const QuillSearchConfigurations(
                  searchEmbedMode: SearchEmbedMode.plainText,
                ),
                sharedConfigurations: _sharedConfigurations,
              ),
              scrollController: _editorScrollController,
              focusNode: _editorFocusNode,
            ),
          );
        },
      ),
    );
  }

  QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      // locale: Locale('en'),
      extraConfigurations: {
        QuillSharedExtensionsConfigurations.key:
            QuillSharedExtensionsConfigurations(
          assetsPrefix: 'assets', // Defaults to assets
        ),
      },
    );
  }
}
