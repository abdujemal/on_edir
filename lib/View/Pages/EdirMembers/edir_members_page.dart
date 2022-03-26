import 'package:flutter/material.dart';
import 'package:on_edir/View/Widgets/edir_member_item.dart';
import 'package:on_edir/constants.dart';

class EdirMembersPage extends StatefulWidget {
  const EdirMembersPage({ Key key }) : super(key: key);

  @override
  State<EdirMembersPage> createState() => _EdirMembersPageState();
}

class _EdirMembersPageState extends State<EdirMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, title: Text("EdirName Members"),centerTitle: true,),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: ((context, index) => EdirMemberItem())),
      ),
    );
  }
}