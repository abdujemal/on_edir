import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class EdirDrawer extends StatefulWidget {
  const EdirDrawer({Key key}) : super(key: key);

  @override
  State<EdirDrawer> createState() => _EdirDrawerState();
}

class _EdirDrawerState extends State<EdirDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
            CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.all(0),
              title: Text("Edir Name", style: TextStyle(fontSize: 17),),
              subtitle: Text("created by Kebe",style: TextStyle(fontSize: 13,color: Color.fromARGB(255, 197, 197, 197)),),
              children: [
                Row(children: [
                  Icon(Icons.add),
                  Text("Add Edir")
                ],
                ),
              ]),
          ]),
        ),
      ),
    );
  }
}
