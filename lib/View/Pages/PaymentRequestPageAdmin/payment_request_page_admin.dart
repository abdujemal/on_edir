import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/PaymentRequestForm/payment_request_form.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/request_item_admin.dart';
import 'package:on_edir/constants.dart';

class PaymentRequestPageAdmin extends StatefulWidget {
  EdirMember edirMember;

  PaymentRequestPageAdmin(
      {Key key, @required this.edirMember})
      : super(key: key);

  @override
  State<PaymentRequestPageAdmin> createState() =>
      _PaymentRequestPageAdminState();
}

class _PaymentRequestPageAdminState extends State<PaymentRequestPageAdmin> {
  DatabaseReference requestRef =
      FirebaseDatabase.instance.ref().child("PaymentRequest");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Request List"),
          centerTitle: true,
        ),
        floatingActionButton: CommonBtn(
            text: "Send Request",
            action: () {
              Get.to(() => PaymentRequestForm(members: [widget.edirMember]));
            }),
        body: StreamBuilder(
          stream: requestRef.child(widget.edirMember.uid).onValue,
          builder: (context, snapshot) {
            List<PaymentRequest> reqList = [];
            if (snapshot.hasData) {
              if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value);
                for (Map<dynamic, dynamic> reqData in data.values) {
                  if (reqData != null) {
                    PaymentRequest paymentRequest =
                        PaymentRequest.fromFirebaseMap(reqData);
                    reqList.add(paymentRequest);
                  }
                }
                reqList.sort(((a, b) =>
                    a.eid.toLowerCase().compareTo(b.eid.toLowerCase())));
              }
            }
            return reqList.isEmpty
                ? const Center(
                    child: Text("No Request"),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ListView.builder(
                        itemCount: reqList.length,
                        itemBuilder: (context, index) => RequestItemAdmin(
                              paymentRequest: reqList[index],
                            )),
                  );
          },
        ),
      ),
    );
  }
}
