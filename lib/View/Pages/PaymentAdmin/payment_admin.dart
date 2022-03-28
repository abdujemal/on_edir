import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/edir_member_fr_payment.dart';
import 'package:on_edir/constants.dart';

class PaymentAdmin extends StatefulWidget {
  const PaymentAdmin({Key key}) : super(key: key);

  @override
  State<PaymentAdmin> createState() => _PaymentAdminState();
}

class _PaymentAdminState extends State<PaymentAdmin> {
  DatabaseReference membersRef =
      FirebaseDatabase.instance.ref().child("EdirMembers");

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            DropdownButton(
                icon: const Icon(FontAwesomeIcons.ellipsisH),
                items: const [ DropdownMenuItem(child: Text("Send Request To All"))],
                onChanged: (v) {})
          ],
          backgroundColor: Colors.transparent,
          title: const Text("EdirName Members"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: membersRef
                .child(edirPAgeController.currentEdir.value.eid)
                .onValue,
            builder: (context, snapshot) {
              List<EdirMember> edirList = [];
              if (snapshot.hasData) {
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value);

                for (Map<dynamic, dynamic> memberData in data.values) {
                  EdirMember edirMember =
                      EdirMember.fromFirebaseMap(memberData);
                  edirList.add(edirMember);
                }
              }
              return 
              edirList.isNotEmpty ?
              const CircularProgressIndicator():
              ListView.builder(
                  itemCount: edirList.length,
                  itemBuilder: ((context, index) =>
                      EdirMemberFrPayment(img_url: edirList[index].img_url, name: edirList[index].userName, position: edirList[index].position)));
            }),
      ),
    );
  }
}
