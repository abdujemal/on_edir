import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/store_item_request.dart';
import 'package:on_edir/View/Widgets/store_request_item_admin.dart';
import 'package:on_edir/constants.dart';

class StoreManagementAdmin extends StatefulWidget {
  const StoreManagementAdmin({Key? key}) : super(key: key);

  @override
  State<StoreManagementAdmin> createState() => _StoreManagementAdminState();
}

class _StoreManagementAdminState extends State<StoreManagementAdmin> {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child("StoreItemRentRequest");

  UserService userService = Get.put(UserService());
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
        body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            List<StoreItemRequest>? list;
            if (snapshot.hasData) {
              list = [];
              if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                Map<dynamic, dynamic> data = 
                    (snapshot.data as DatabaseEvent).snapshot.value as Map ;

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
                        itemBuilder: (context, index) => StoreRequestItemAdmin(
                            userService: userService,
                            storeItemRequest: list![index]));
          },
        ),
      ),
    );
  }
}
