import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/constants.dart';

class PaymentRequestPageAdmin extends StatefulWidget {
  String uid;
  PaymentRequestPageAdmin({Key key, @required this.uid}) : super(key: key);

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
        body: StreamBuilder(
          stream: requestRef.child(widget.uid).onValue,
          builder: (context, snapshot) {
            List<PaymentRequest> reqList = [];
            if (snapshot.hasData) {
              if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                    (snapshot.data as DatabaseEvent).snapshot.value);
                for (Map<dynamic, dynamic> reqData in data.values) {
                  if (reqData != null) {
                    PaymentRequest paymentRequest =
                        PaymentRequest.fromFirebaseMap(data);
                    reqList.add(paymentRequest);
                  }
                }
                reqList..sort(((a, b) =>
                    a.eid.toLowerCase().compareTo(b.eid.toLowerCase())));
              }
            }
            return reqList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: reqList.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(height: 30, width: 30, color: Colors.white),
                        ));
          },
        ),
      ),
    );
  }
}
