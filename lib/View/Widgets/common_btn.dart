import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class CommonBtn extends StatelessWidget {
  String text;
  void Function() action;
  CommonBtn({Key? key, required this.text, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Ink(
        decoration: BoxDecoration(gradient: btnGradient,borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(text,style: TextStyle(fontSize: 22),),
        ),
      ),
    );
  }
}
