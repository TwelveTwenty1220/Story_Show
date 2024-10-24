import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;  // 确保你添加了 http 依赖
import 'dart:convert';  // 用于处理 JSON 编码

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  List<File?> _images = List.generate(9, (_) => null); // 初始化 9 个位置
  String statusMessage = "等待上传";

  // 选择照片
  Future<void> _pickImages(int index) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path); // 更新选中的图片
      });
    }
  }

  // 上传照片
  Future<void> _uploadImages() async {
    String url = 'http://121.250.212.62:54324/';

    for (var image in _images) {
      if (image != null) {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(await http.MultipartFile.fromPath('file', image.path));
        request.fields['value'] = '我来了';

        var response = await request.send();

        if (response.statusCode == 200) {
          setState(() {
            statusMessage = '上传成功';
          });
        } else {
          setState(() {
            statusMessage = '上传失败: ${response.statusCode}';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('上传并保存照片'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: _uploadImages, // 上传所有选中的图片
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,  // 每行显示 3 个图片
          childAspectRatio: 1,
        ),
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _pickImages(index), // 点击选择图片
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: _images[index] != null ? Colors.blue : Colors.transparent,
                  width: 2,
                ),
              ),
              child: _images[index] == null
                  ? Center(child: Text('选择图片')) // 没有选择图片时的提示
                  : Image.file(
                _images[index]!,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(statusMessage, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
