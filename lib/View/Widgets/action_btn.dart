import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  String text;
  void Function() action;
  ActionBtn({Key? key, required this.text, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Ink(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(color: Color.fromARGB(255, 201, 201, 201)),
        ),
      ),
    );
  }
}
