import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/store_item_request.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/constants.dart';

class StoreManagementAdmin extends StatefulWidget {
  const StoreManagementAdmin({Key key}) : super(key: key);

  @override
  State<StoreManagementAdmin> createState() => _StoreManagementAdminState();
}

class _StoreManagementAdminState extends State<StoreManagementAdmin> {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child("StoreItemRentRequest");



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Store Managment"),
        ),
        body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            List<StoreItemRequest> list;
            if (snapshot.hasData) {
              list = [];
              Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                  (snapshot.data as DatabaseEvent).snapshot.value);
              for (Map<dynamic, dynamic> reqData in data.values) {
                if (reqData != null) {
                  StoreItemRequest storeItemRequest =
                      StoreItemRequest.fromFirebaseMap(reqData);
                 
                    list.add(storeItemRequest);
                 
                }
              }
              list.sort(((a, b) =>
                  a.eid.toLowerCase().compareTo(b.eid.toLowerCase())));
            }
            return 
            list == null ?
            const Center(child: CircularProgressIndicator(),):
            list.isEmpty ?
            const Center(child: Text("No Request"),):
            ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Container());
          },
        ),
      ),
    );
  }
}
