import 'package:flutter/material.dart';

import 'package:gif_view/gif_view.dart';

class GifViewer extends StatefulWidget {
  const GifViewer({super.key});

  @override
  State<GifViewer> createState() => _GifViewerState();
}

class _GifViewerState extends State<GifViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GifView.network(
          'http://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/BadgeSandals.gif',
          height: 200,
        ),
      ],
    );
  }
}
