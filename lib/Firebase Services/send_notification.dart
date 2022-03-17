import 'dart:convert';
import 'package:http/http.dart' as http;

class SendNotification {
  String title, body, topic;

  SendNotification(
      {required this.title, required this.body, required this.topic});

  Future<bool> send() async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/${topic}",
      "collapse_key" : "type_a",
      "notification": {
        "title": title,
        "body": body,
      }
    };

    final headers = <String, String>{
      'content-type': 'application/json',
      'Authorization':
          "key=AAAAcqzqEUg:APA91bFz_PjuKTMYikk-qXHTU7pAhusnfedDagDqj4Fi9C-cPExelvi2zlkrOrW8fwTWhKrnCfv6trNlMRI70lW2TwpjgIvBSUe6kdOv3wbdJ6s5VjvAvCXHOKCLXtx_QAGsUaDFWd9l" // 'key=YOUR_SERVER_KEY'
    };

    

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(response.body.toString());
      // on failure do sth
      return false;
    }
  }
}
