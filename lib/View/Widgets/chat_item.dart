import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class ChatItem extends StatelessWidget {
  String userName, text, img_url;
  ChatItem({
    Key? key,
    required this.userName,
    required this.text,
    required this.img_url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(img_url),
                radius: 26,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    userName,
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
