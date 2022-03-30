import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/announcement.dart';
import 'package:on_edir/View/Pages/AddAnnouncementPage/add_announcement_page.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/announcement_item.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/custom_fab.dart';
import 'package:on_edir/constants.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  DatabaseReference announcementRef =
      FirebaseDatabase.instance.ref().child("Announcements");

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => StreamBuilder(
            stream: announcementRef
                .child(edirPAgeController.currentEdir.value.eid)
                .onValue,
            builder: (context, snapshot) {
              List<Announcement> announcementList;
              if (snapshot.hasData) {
                announcementList = [];
                if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
                  Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                      (snapshot.data as DatabaseEvent).snapshot.value);
                  for (Map<dynamic, dynamic> anounceData in data.values) {
                    Map<dynamic, dynamic> adata =
                        Map<dynamic, dynamic>.from(anounceData);
                    Announcement announcement =
                        Announcement.fromFirebaseMap(adata);
                    // print(anounceData);
                    if (announcement.aid != null) {
                      announcementList.add(announcement);
                    }
                  }
                  announcementList.sort(((a, b) =>
                      a.aid.toLowerCase().compareTo(b.aid.toLowerCase())));
                }
              }
              return 
              announcementList == null?
              const Center(child: CircularProgressIndicator(),):
              announcementList.isEmpty
                  ? const Center(
                      child: Text("No Announcement"),
                    )
                  : ListView.builder(
                      itemCount: announcementList.length,
                      itemBuilder: (context, index) => AnnouncementItem(
                          announcement: announcementList[index]));
            })),
        Obx(() => edirPAgeController.currentEdir.value.created_by !=
                mainController.myInfo.value.uid
            ? const SizedBox()
            : Align(
                alignment: Alignment.bottomRight,
                child: CustomFab(
                  icon: Icons.add,
                  onTap: () {
                    Get.to(() => const AddAnnouncement());
                  },
                )))
      ],
    );
  }
}
