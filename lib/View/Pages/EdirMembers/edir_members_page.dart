// ignore_for_file: missing_return

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/edir_member_item.dart';
import 'package:on_edir/constants.dart';

class EdirMembersPage extends StatefulWidget {
  const EdirMembersPage({Key key}) : super(key: key);

  @override
  State<EdirMembersPage> createState() => _EdirMembersPageState();
}

class _EdirMembersPageState extends State<EdirMembersPage> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  DatabaseReference memberRef =
      FirebaseDatabase.instance.ref().child("EdirMembers");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:
              Text("${edirPAgeController.currentEdir.value.edirName} ${'Members'.tr}"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream:
              memberRef.child(edirPAgeController.currentEdir.value.eid).onValue,
          builder: ((context, snapshot) {
            List<EdirMember> memberList;
            if (snapshot.hasData) {
              memberList = [];
              Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                  (snapshot.data as DatabaseEvent).snapshot.value);
              for (Map<dynamic, dynamic> memberData in data.values) {
                Map<dynamic, dynamic> data =
                    Map<dynamic, dynamic>.from(memberData);
                EdirMember edirMember = EdirMember.fromFirebaseMap(data);
                memberList.add(edirMember);
              }
            }
            return
            memberList == null?
            const Center(child: CircularProgressIndicator(),):
             memberList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: memberList.length,
                    itemBuilder: (context, index) => EdirMemberItem(
                        imgUrl: memberList[index].img_url,
                        title: memberList[index].userName,
                        subtitle: memberList[index].position,
                        onTap: () {}));
          }),
        ),
      ),
    );
  }
}
