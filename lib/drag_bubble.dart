import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class DragBubbleScreen extends StatefulWidget {
  @override
  _DragBubbleScreenState createState() => _DragBubbleScreenState();
}

class _DragBubbleScreenState extends State<DragBubbleScreen> {
  Offset bubblePosition = Offset(100, 100); // 初始化气泡框的位置

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖动气泡框'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: bubblePosition.dx,
            top: bubblePosition.dy,
            child: Draggable(
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
              feedback: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
              onDragUpdate: (details) {
                // 更新气泡框位置
                setState(() {
                  bubblePosition += details.delta; // 根据拖动的增量更新位置
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
