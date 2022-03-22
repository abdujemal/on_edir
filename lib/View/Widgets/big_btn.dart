import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class BigBtn extends StatelessWidget {
  String text;
  IconData icon;
  void Function() action;
  BigBtn({Key key, @required this.text, @required this.icon, @required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Ink(
        width: 200,
        decoration: BoxDecoration(
            gradient: btnGradient, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Icon(
              icon,
              size: 60,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 25),
            )
          ]),
        ),
      ),
    );
  }
}
