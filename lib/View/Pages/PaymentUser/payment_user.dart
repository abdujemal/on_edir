import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/request_item_user.dart';
import 'package:on_edir/constants.dart';

class PaymentUser extends StatefulWidget {
  const PaymentUser({Key key}) : super(key: key);

  @override
  State<PaymentUser> createState() => _PaymentUserState();
}

class _PaymentUserState extends State<PaymentUser> {
  DatabaseReference requestRef =
      FirebaseDatabase.instance.ref().child("PaymentRequest");

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("My Payment Request"),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: requestRef.child(mainController.myInfo.value.uid).onValue,
          builder: (context, snapshot) {
            List<PaymentRequest> reqList;
            if (snapshot.hasData) {
              reqList = [];
              if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value);
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
                    a.eid.toLowerCase().compareTo(b.eid.toLowerCase())));
              }
            }
            return 
            reqList == null?
            const Center(child: CircularProgressIndicator(),):
            reqList.isEmpty
                ? const Center(
                    child: Text("No Request"),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListView.builder(
                        itemCount: reqList.length,
                        itemBuilder: (context, index) => RequestItemUser(
                              paymentRequest: reqList[index],
                            )),
                  );
          },
        ),
      ),
    );
  }
}
