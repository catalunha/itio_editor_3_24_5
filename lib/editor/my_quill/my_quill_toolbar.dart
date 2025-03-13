import 'dart:convert';
import 'dart:io' as io show File;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/flutter_quill_internal.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import 'package:itio_editor/editor/utils/color_utils.dart';

import '../cubit/text_editor_cubit.dart';
import '../cubit/text_editor_state.dart';
import '../utils/app_copy.dart';

class MyQuillToolbar extends StatelessWidget with AppCopy {
  const MyQuillToolbar({
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final QuillController controller;
  final FocusNode focusNode;

  Future<void> onImageInsertWithCropping(
    String image,
    QuillController controller,
    BuildContext context,
  ) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    final newImage = croppedFile?.path;
    if (newImage == null) {
      return;
    }
    if (kIsWeb) {
      controller.insertImageBlock(imageSource: newImage);
      return;
    }
    final newSavedImage = await saveImage(io.File(newImage));
    controller.insertImageBlock(imageSource: newSavedImage);
  }

  Future<void> onImageInsert(String image, QuillController controller) async {
    if (kIsWeb || isHttpBasedUrl(image)) {
      controller.insertImageBlock(imageSource: image);
      return;
    }
    final newSavedImage = await saveImage(io.File(image));
    controller.insertImageBlock(imageSource: newSavedImage);
  }

  /// For mobile platforms it will copies the picked file from temporary cache
  /// to applications directory
  ///
  /// for desktop platforms, it will do the same but from user files this time
  Future<String> saveImage(io.File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final fileExt = path.extension(file.path);
    final newFileName = '${DateTime.now().toIso8601String()}$fileExt';
    final newPath = path.join(
      appDocDir.path,
      newFileName,
    );
    final copiedFile = await file.copy(newPath);
    return copiedFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextEditorCubit, TextEditorState>(
      buildWhen: (previous, current) =>
          previous.useCustomQuillToolbar != current.useCustomQuillToolbar,
      builder: (context, state) {
        if (state.useCustomQuillToolbar) {
          // For more info
          // https://github.com/singerdmx/flutter-quill/blob/master/doc/custom_toolbar.md
          return QuillToolbar(
            configurations: const QuillToolbarConfigurations(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                children: [
                  IconButton(
                    onPressed: () => context
                        .read<TextEditorCubit>()
                        .updateSettings(useCustomQuillToolbar: false),
                    icon: const Icon(
                      Icons.width_normal,
                    ),
                  ),
                  QuillToolbarHistoryButton(
                    isUndo: true,
                    controller: controller,
                  ),
                  QuillToolbarHistoryButton(
                    isUndo: false,
                    controller: controller,
                  ),
                  QuillToolbarToggleStyleButton(
                    options: const QuillToolbarToggleStyleButtonOptions(),
                    controller: controller,
                    attribute: Attribute.bold,
                  ),
                  QuillToolbarToggleStyleButton(
                    options: const QuillToolbarToggleStyleButtonOptions(),
                    controller: controller,
                    attribute: Attribute.italic,
                  ),
                  QuillToolbarToggleStyleButton(
                    controller: controller,
                    attribute: Attribute.underline,
                  ),
                  QuillToolbarClearFormatButton(
                    controller: controller,
                  ),
                  const VerticalDivider(),
                  QuillToolbarImageButton(
                    controller: controller,
                  ),
                  QuillToolbarCameraButton(
                    controller: controller,
                  ),
                  QuillToolbarVideoButton(
                    controller: controller,
                  ),
                  const VerticalDivider(),
                  QuillToolbarColorButton(
                    controller: controller,
                    isBackground: false,
                  ),
                  QuillToolbarColorButton(
                    controller: controller,
                    isBackground: true,
                  ),
                  const VerticalDivider(),
                  QuillToolbarSelectHeaderStyleDropdownButton(
                    controller: controller,
                    options: QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                        attributes: [
                          Attribute.h1,
                          Attribute.h2,
                          Attribute.h3,
                          Attribute.h4,
                          Attribute.h5,
                          Attribute.h6,
                          Attribute.header,
                        ]),
                  ),
                  const VerticalDivider(),
                  QuillToolbarSelectLineHeightStyleDropdownButton(
                    controller: controller,
                  ),
                  const VerticalDivider(),
                  QuillToolbarToggleCheckListButton(
                    controller: controller,
                  ),
                  QuillToolbarToggleStyleButton(
                    controller: controller,
                    attribute: Attribute.ol,
                  ),
                  QuillToolbarToggleStyleButton(
                    controller: controller,
                    attribute: Attribute.ul,
                  ),
                  QuillToolbarToggleStyleButton(
                    controller: controller,
                    attribute: Attribute.inlineCode,
                  ),
                  QuillToolbarToggleStyleButton(
                    controller: controller,
                    attribute: Attribute.blockQuote,
                  ),
                  QuillToolbarIndentButton(
                    controller: controller,
                    isIncrease: true,
                  ),
                  QuillToolbarIndentButton(
                    controller: controller,
                    isIncrease: false,
                  ),
                  const VerticalDivider(),
                  QuillToolbarLinkStyleButton(controller: controller),
                ],
              ),
            ),
          );
        }
        return QuillToolbar.simple(
          controller: controller,

          /// configurations parameter:
          ///   Optional: if not provided will use the configuration set when the controller was instantiated.
          ///   Override: Provide parameter here to override the default configuration - useful if configuration will change.
          configurations: QuillSimpleToolbarConfigurations(
            showSubscript: false,
            showSuperscript: false,
            showClipboardCut: false,
            showCodeBlock: false,
            // showDirection: false,
            showAlignmentButtons: true,
            showListCheck: false,
            showSearchButton: false,
            showLink: false,
            // showHeaderStyle: false,
            multiRowsDisplay: true,
            fontFamilyValues: {
              // 'Amatic': GoogleFonts.amaticSc().fontFamily!,
              // 'Annie': GoogleFonts.annieUseYourTelescope().fontFamily!,
              // 'Formal': GoogleFonts.petitFormalScript().fontFamily!,
              // 'Roboto': GoogleFonts.roboto().fontFamily!
              'Hebrew font': 'SBL_Hebrew',
              'Greek font': 'GentiumPlus',
              'Noto Sans': 'NotoSans',
              'Clear': 'Clear'
            },
            fontSizesValues: const {
              '14': '14.0',
              '16': '16.0',
              '18': '18.0',
              '20': '20.0',
            },
            searchButtonType: SearchButtonType.modern,
            buttonOptions: QuillSimpleToolbarButtonOptions(
                selectHeaderStyleDropdownButton:
                    QuillToolbarSelectHeaderStyleDropdownButtonOptions(
                        attributes: [
                  Attribute.h1,
                  Attribute.h2,
                  Attribute.h3,
                  Attribute.h4,
                  Attribute.h5,
                  Attribute.h6,
                  Attribute.header,
                ])),
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

                      controller.document = Document.fromJson(json);
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
                    jsonEncode(controller.document.toDelta().toJson()),
                    'The text json has been copied to the clipboard and Viewer tab.',
                  );
                  context.read<TextEditorCubit>().saveText(
                      jsonEncode(controller.document.toDelta().toJson()));
                },
              ),
              QuillToolbarCustomButtonOptions(
                tooltip: 'mainEmphasis color ${Colors.cyan.toHex()}',
                icon: Icon(
                  Icons.color_lens_outlined,
                  color: Colors.cyan,
                ),
                onPressed: () {
                  controller
                      .formatSelection(BiblingoColorAttr(Colors.cyan.toHex()));
                },
              ),
              // QuillToolbarCustomButtonOptions(
              //   tooltip:
              //       'alternateEmphasis color ${Theme.of(context).extension<ExtendedColors>()?.alternateEmphasis?.toHex()}',
              //   icon: Icon(
              //     Icons.color_lens_outlined,
              //     color: Theme.of(context)
              //         .extension<ExtendedColors>()
              //         ?.alternateEmphasis,
              //   ),
              //   onPressed: () {
              //     _controller.formatSelection(BiblingoColorAttr(
              //         Theme.of(context)
              //             .extension<ExtendedColors>()
              //             ?.alternateEmphasis
              //             ?.toHex()));
              //   },
              // ),
              QuillToolbarCustomButtonOptions(
                icon: Icon(
                  Icons.stacked_bar_chart,
                ),
                onPressed: () => context
                    .read<TextEditorCubit>()
                    .updateSettings(useCustomQuillToolbar: true),
              ),
            ],
            embedButtons: FlutterQuillEmbeds.toolbarButtons(
              imageButtonOptions: QuillToolbarImageButtonOptions(
                imageButtonConfigurations: QuillToolbarImageConfigurations(
                  onImageInsertCallback: onImageInsert,
                  // ? (image, controller) =>
                  //     onImageInsertWithCropping(image, controller, context)
                  // : onImageInsert,
                ),
              ),
              videoButtonOptions: null,
              cameraButtonOptions: null,
            ),
          ),
        );
      },
    );
  }
}

class BiblingoColorAttr extends Attribute<String?> {
  const BiblingoColorAttr(String? value)
      : super('color', AttributeScope.inline, value);
}
