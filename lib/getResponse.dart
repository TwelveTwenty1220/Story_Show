import 'package:http/http.dart' as http;
import 'dart:convert';


void sendPostRequest(String urlString,String imageUrl) async {
  var url = Uri.parse(urlString);
  var body = jsonEncode({
    'key': imageUrl,  // 替换为你需要发送的数据
  });

  try {
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('Response data: $responseData');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}