import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class EdirMemberFrPayment extends StatelessWidget {
  String img_url, name, position;
  void Function() onTap;
  
  EdirMemberFrPayment(
      {Key key,
      @required this.img_url,
      @required this.name,
      @required this.position,
      @required this.onTap})
      : super(key: key);

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
                    backgroundImage: NetworkImage(img_url),
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
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    position,
                    style: TextStyle(
                        color: Colors.grey, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              const Spacer(),
              // ActionBtn(text: "Send Request", action: () {})
            ],
          ),
        ),
      ),
    );
  }
}
