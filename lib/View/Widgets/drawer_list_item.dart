import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  String text;
  IconData icon;
  void Function() action;

  DrawerListItem(
      {Key? key,
      required this.text,
      required this.action,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Ink(
        padding: const EdgeInsets.only(top: 12, bottom: 12,left: 16),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
