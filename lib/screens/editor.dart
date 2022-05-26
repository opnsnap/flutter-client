// Edit a captured image:
// - https://docs.flutter.dev/cookbook/effects/photo-filter-carousel
// - https://api.flutter.dev/flutter/dart-ui/ImageFilter-class.html
// - https://pub.dev/packages/photofilters
// - https://invidious.namazso.eu/watch?v=7Lftorq4i2o&vl=en

import 'dart:io';
import 'package:flutter/material.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key, required this.image});

  final File image;

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.file(widget.image)
        ,
      ),
    );
  }
}
