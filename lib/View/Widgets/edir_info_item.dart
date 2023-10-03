import 'package:flutter/material.dart';

class EdirInfoItem extends StatelessWidget {
  String title;
  String value;
  EdirInfoItem({ Key? key, required this.title, required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title+":"),
          Text(value)
        ],
      ),
    );
  }
}