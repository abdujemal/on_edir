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
          "key=AAAA4NLzuXc:APA91bFn_j4JW2rxpio0ZCgFaQN1kltz_bIcLBPuI7d2IeAP0Ag7IC0uT-oofC_X1eYmjB0lb0M-iNvP6Hkuo1L8-OOoosMl0WfwTe9_OisGxb6N6wdO-RZ-WqAizxRgqYSQW-eOPlsm" // 'key=YOUR_SERVER_KEY'
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
