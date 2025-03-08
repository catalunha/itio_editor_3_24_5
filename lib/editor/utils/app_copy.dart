import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin AppCopy {
  void copyToClipboard(BuildContext context, String message, String alert) {
    Future<void> copyToClipboard() async {
      await Clipboard.setData(
        ClipboardData(text: message),
      );
    }

    copyToClipboard();
    showMessage(context, alert);
  }

  Future<String> pasteFromClipboard(BuildContext context, String alert) async {
    Future<String> pasteFromClipboard() async {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final String? clipboardText = clipboardData?.text;
      return clipboardText ?? '';
    }

    showMessage(context, alert);
    final String value = await pasteFromClipboard();
    return value;
  }

  void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            msg,
            // style: const TextStyle(color: Colors.black),
          ),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          // backgroundColor: color,
        ),
      );
  }
}
