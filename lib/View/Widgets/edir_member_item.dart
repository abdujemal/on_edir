import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class EdirMemberItem extends StatelessWidget {
  String imgUrl, title, subtitle;
  void Function() onTap;
  EdirMemberItem({Key key, @required this.imgUrl, @required this.title, @required this.subtitle, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
            color: mainColor,
            border: Border(bottom: BorderSide(color: secondColor))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
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
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.grey, overflow: TextOverflow.ellipsis),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
