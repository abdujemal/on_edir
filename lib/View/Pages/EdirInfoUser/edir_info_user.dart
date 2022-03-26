import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:on_edir/View/Widgets/edir_info_item.dart';
import 'package:on_edir/constants.dart';

class EdirInfoUser extends StatefulWidget {
  EdirInfoUser({
    Key key,
  }) : super(key: key);

  @override
  State<EdirInfoUser> createState() => _EdirInfoUserState();
}

class _EdirInfoUserState extends State<EdirInfoUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Edir Info"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            EdirInfoItem(title: "Edir Name", value: "Edir Name"),
            EdirInfoItem(title: "Edir Bio", value: "Edir Name"),
            EdirInfoItem(title: "Edir Address", value: "Edir Name"),
            EdirInfoItem(title: "Amount Of Money", value: "Edir Name"),
            EdirInfoItem(title: "Duration Of Payment", value: "Edir Name"),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Center(child: Text("Edir Rules And Regulations",style: TextStyle(fontSize: 20),),),
                SizedBox(height: 20,),
                Text("Rules")
                
              ],),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Bank Account Options",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(children: const [
                    ListTile(
                      trailing: Icon(Icons.payment),
                      title: Text("bank"),
                      subtitle: Text("account"),
                    ),
                  ])
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
