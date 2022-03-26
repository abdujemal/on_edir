import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class EdirMemberItem extends StatelessWidget {
  const EdirMemberItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          border: Border(bottom: BorderSide(color: secondColor))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.account_circle,size: 40,),
                ),
                Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
                ),
              )
              ],
            ),
            const SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Member name",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text("Member Position",style: TextStyle(color: Colors.grey,overflow: TextOverflow.ellipsis),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
