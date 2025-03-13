import 'package:flutter/material.dart';

import 'package:gif_view/gif_view.dart';

class GifPage extends StatefulWidget {
  const GifPage({super.key});

  @override
  State<GifPage> createState() => _GifPageState();
}

class _GifPageState extends State<GifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gif_view: ^1.0.0'),
      ),
      body: Column(
        children: [
          Text('Image assets'),
          GifView.asset(
            'assets/images/a.png',
            height: 200,
          ),
          Text('Gif assets'),
          GifView.asset(
            'assets/images/b.png',
            height: 200,
          ),
          Text('Image network'),
          GifView.network(
            'https://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/_After.png',
            height: 200,
          ),
          Text('Gif network'),
          GifView.network(
            'http://biblingoprod.s3.amazonaws.com/assets/app/badges/Items/Sandals/BadgeSandals.gif',
            height: 200,
          ),
        ],
      ),
    );
  }
}
