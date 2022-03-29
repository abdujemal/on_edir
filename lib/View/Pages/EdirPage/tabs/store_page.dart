import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/store.dart';
import 'package:on_edir/View/Pages/AddStoreItemPage/add_store_item.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/custom_fab.dart';
import 'package:on_edir/View/Widgets/stroe_item.dart';
import 'package:on_edir/constants.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  MainController mainController = Get.put(MainController());

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Store");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => StreamBuilder(
            stream: ref.child(edirPAgeController.currentEdir.value.eid).onValue,
            builder: (context, snapshot) {
              List<Store> storeList = [];
              if (snapshot.hasData) {
                if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                  Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                      (snapshot.data as DatabaseEvent).snapshot.value);
                  for (Map<dynamic, dynamic> storeData in data.values) {
                    Store store = Store.fromFirebaseMap(storeData);
                    if (store.img_url != null) {
                      storeList.add(store);
                    }
                  }

                  storeList.sort(((a, b) =>
                      a.sid.toLowerCase().compareTo(b.sid.toLowerCase())));
                }
              }
              return storeList.isEmpty
                  ? const Center(
                      child: Text("No Store Item"),
                    )
                  : ListView.builder(
                      itemCount: storeList.length,
                      itemBuilder: (context, index) => StoreItem(
                            store: storeList[index],
                          ));
            },
          ),
        ),
        Obx(() => edirPAgeController.currentEdir.value.created_by !=
                mainController.myInfo.value.uid
            ? const SizedBox()
            : Align(
                alignment: Alignment.bottomRight,
                child: CustomFab(
                  icon: Icons.add,
                  onTap: () {
                    Get.to(() => const AddStoreItem());
                  },
                ),
              ))
      ],
    );
  }
}
