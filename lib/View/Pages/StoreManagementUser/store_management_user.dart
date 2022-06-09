import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/store_item_request.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';

import '../../../constants.dart';

class StoreManagemntUser extends StatefulWidget {
  const StoreManagemntUser({Key key}) : super(key: key);

  @override
  State<StoreManagemntUser> createState() => _StoreManagemntUserState();
}

class _StoreManagemntUserState extends State<StoreManagemntUser> {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child("StoreItemRentRequest");

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Store Managment".tr),
        ),
       
        body: Stack(
          children: [
            StreamBuilder(
              stream: ref.onValue,
              builder: (context, snapshot) {
                List<StoreItemRequest> list;
                if (snapshot.hasData) {
                  list = [];
                  if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                    Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                        (snapshot.data as DatabaseEvent).snapshot.value);
                    for (Map<dynamic, dynamic> reqData in data.values) {
                      if (reqData != null) {
                        StoreItemRequest storeItemRequest =
                            StoreItemRequest.fromFirebaseMap(reqData);
                        if (storeItemRequest.uid ==
                            mainController.myInfo.value.uid) {
                          list.add(storeItemRequest);
                        }
                      }
                    }
                    list.sort(((a, b) =>
                        a.eid.toLowerCase().compareTo(b.eid.toLowerCase())));
                  }
                }
                return list == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : list.isEmpty
                        ? Center(
                            child: Text("No Request".tr),
                          )
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) => Container());
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
