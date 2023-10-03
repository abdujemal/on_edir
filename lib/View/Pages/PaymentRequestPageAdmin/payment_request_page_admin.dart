import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/PaymentRequestForm/payment_request_form.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/request_item_admin.dart';
import 'package:on_edir/constants.dart';

class PaymentRequestPageAdmin extends StatefulWidget {
  final EdirMember edirMember;

  const PaymentRequestPageAdmin({Key? key, required this.edirMember})
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
          title: Text("Request List".tr),
          centerTitle: true,
        ),
        floatingActionButton: CommonBtn(
            text: "Send Request".tr,
            action: () {
              Get.to(() => PaymentRequestForm(members: [widget.edirMember]));
            }),
        body: StreamBuilder(
          stream: requestRef.child(widget.edirMember.uid).onValue,
          builder: (context, snapshot) {
            List<PaymentRequest>? reqList;
            if (snapshot.hasData) {
              reqList = [];
              if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value as Map);
                for (Map<dynamic, dynamic> reqData in data.values) {
                  if (reqData != null) {
                    PaymentRequest paymentRequest =
                        PaymentRequest.fromFirebaseMap(reqData);
                    if (paymentRequest.pid != null) {
                      reqList.add(paymentRequest);
                    }
                  }
                }
                reqList.sort(((a, b) =>
                    b.pid.toLowerCase().compareTo(a.pid.toLowerCase())));
              }
            }
            return 
            reqList == null?
            const Center(child: CircularProgressIndicator(),):
            reqList.isEmpty
                ? Center(
                    child: Text("No Request".tr),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ListView.builder(
                        itemCount: reqList.length,
                        itemBuilder: (context, index) => RequestItemAdmin(
                              paymentRequest: reqList![index],
                            )),
                  );
          },
        ),
      ),
    );
  }
}
