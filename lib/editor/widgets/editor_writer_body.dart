import 'dart:convert';
import 'dart:io' as io show Directory, File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart' as path;

import 'package:itio_editor/editor/utils/color_utils.dart';

import '../cubit/text_editor_cubit.dart';
import '../my_quill/my_quill_editor.dart';
import '../my_quill/my_quill_toolbar.dart';
import '../utils/app_copy.dart';

class EditorWriterBody extends StatefulWidget {
  const EditorWriterBody({super.key});

  @override
  State<EditorWriterBody> createState() => _EditorWriterBodyState();
}

class _EditorWriterBodyState extends State<EditorWriterBody> with AppCopy {
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
    return Column(
      children: [
        MyQuillToolbar(
          controller: _controller,
          focusNode: _editorFocusNode,
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              return MyQuillEditor(
                controller: _controller,
                configurations: QuillEditorConfigurations(
                    // characterShortcutEvents: standardCharactersShortcutEvents,
                    // spaceShortcutEvents: standardSpaceShorcutEvents,
                    // searchConfigurations: const QuillSearchConfigurations(
                    //   searchEmbedMode: SearchEmbedMode.plainText,
                    // ),
                    // sharedConfigurations: _sharedConfigurations,
                    ),
                scrollController: _editorScrollController,
                focusNode: _editorFocusNode,
              );
            },
          ),
        ),
        /*
        QuillSimpleToolbar(
          controller: _controller,
          config: QuillSimpleToolbarConfig(
            embedButtons: FlutterQuillEmbeds.toolbarButtons(),
            customButtons: [
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.data_object),
                tooltip: 'paste from Clipboard to Editor',
                onPressed: () async {
                  final bool? value = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'Do you want to overwrite the current editor text with the clipboard contents?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          TextButton(
                            child: const Text('CANCEL'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          )
                        ],
                      );
                    },
                  );
                  if (value == true) {
                    try {
                      final clipboardData = await pasteFromClipboard(
                          context, 'Data/Json copied to the Editor area');
    
                      final json = jsonDecode(clipboardData);
    
                      _controller.document = Document.fromJson(json);
                    } catch (e) {
                      showMessage(context,
                          'Oops. The clipboard contents are in a format not readable by the Editor.');
                    }
                  }
                },
              ),
              QuillToolbarCustomButtonOptions(
                icon: const Icon(Icons.save_as_outlined),
                tooltip: 'Save to Viewer/Clipboard',
                onPressed: () {
                  copyToClipboard(
                    context,
                    jsonEncode(_controller.document.toDelta().toJson()),
                    'The text json has been copied to the clipboard and Viewer tab.',
                  );
                  context.read<TextEditorCubit>().saveText(
                      jsonEncode(_controller.document.toDelta().toJson()));
                },
              ),
              QuillToolbarCustomButtonOptions(
                tooltip: 'color #FF9C27B0',
                icon: const Icon(
                  Icons.color_lens_outlined,
                  color: Colors.cyan,
                ),
                onPressed: () {
                  _controller
                      .formatSelection(BiblingoColorAttr(Colors.cyan.toHex()));
                },
              ),
            ],
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarBaseButtonOptions(
                afterButtonPressed: () {
                  final isDesktop = {
                    TargetPlatform.linux,
                    TargetPlatform.windows,
                    TargetPlatform.macOS
                  }.contains(defaultTargetPlatform);
                  if (isDesktop) {
                    _editorFocusNode.requestFocus();
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: QuillEditor(
            controller: _controller,
            focusNode: _editorFocusNode,
            scrollController: _editorScrollController,
            config: QuillEditorConfig(
              placeholder: 'Start writing your notes...',
              padding: const EdgeInsets.all(16),
              embedBuilders: [
                ...FlutterQuillEmbeds.editorBuilders(
                  imageEmbedConfig: QuillEditorImageEmbedConfig(
                    imageProviderBuilder: (context, imageUrl) {
                      // https://pub.dev/packages/flutter_quill_extensions#-image-assets
                      if (imageUrl.startsWith('assets/')) {
                        return AssetImage(imageUrl);
                      }
                      return null;
                    },
                  ),
                  videoEmbedConfig: QuillEditorVideoEmbedConfig(
                    customVideoBuilder: (videoUrl, readOnly) {
                      // To load YouTube videos https://github.com/singerdmx/flutter-quill/releases/tag/v10.8.0
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        */
      ],
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
