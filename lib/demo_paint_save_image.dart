import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 你可以在这里绘制自定义图形
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // 绘制气泡框
    paint.color = Colors.red;
    canvas.drawRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(50, 50, 100, 50), Radius.circular(15)), paint);

    // 绘制文本
    final textPainter = TextPainter(
      text: TextSpan(
        text: '气泡框',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(60, 60));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SaveImageScreen extends StatefulWidget {
  @override
  _SaveImageScreenState createState() => _SaveImageScreenState();
}

class _SaveImageScreenState extends State<SaveImageScreen> {
  GlobalKey _globalKey = GlobalKey();

  Future<void> _saveToImage() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // 将 widget 转换为图片
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // 获取存储路径
    final directory = await getApplicationDocumentsDirectory();
    File imgFile = File('${directory.path}/my_image.png');

    // 保存图片
    await imgFile.writeAsBytes(pngBytes);
    print('图片已保存到：${imgFile.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('保存图片示例'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveToImage,
          ),
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: _globalKey,
          child: CustomPaint(
            size: Size(200, 200), // 设定绘制区域大小
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

