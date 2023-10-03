import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';


class CustomFab extends StatelessWidget {
  IconData icon;
  void Function() onTap;
  CustomFab({Key? key,required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
          onTap: onTap,
          child: Ink(
              decoration: BoxDecoration(
                  color: secondColor, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.add,
                  size: 43,
                ),
              ))),
    );
  }
}
