import 'package:flutter/material.dart';
import 'initPage.dart';
import 'up_pictures.dart';
import 'drag_bubble.dart';
import 'demo_paint_save_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'story demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SaveImageScreen(),
    );
  }
}


