import 'package:flutter/material.dart';
import 'package:on_edir/Model/announcement.dart';
import 'package:on_edir/constants.dart';

class AnnouncementItem extends StatelessWidget {
  Announcement announcement;
  AnnouncementItem({Key? key,required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          border: Border(bottom: BorderSide(color: secondColor))),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            
            Center(child: Text(announcement.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            Center(child: Text(announcement.description)),
            SizedBox(height: 10,),
            Text(announcement.dateTime,style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
