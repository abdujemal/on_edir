
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/View/Pages/EdirGroupChat/edir_group_chat.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/edir_info_admin.dart';
import 'package:on_edir/View/Pages/EdirInfoUser/edir_info_user.dart';
import 'package:on_edir/View/Pages/EdirMembers/edir_members_page.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Pages/MyProfile/my_profile.dart';
import 'package:on_edir/View/Pages/PaymentAdmin/payment_admin.dart';
import 'package:on_edir/View/Pages/PaymentUser/payment_user.dart';
import 'package:on_edir/View/Pages/StoreManagementAdmin/store_management_admin.dart';
import 'package:on_edir/View/Pages/StoreManagementUser/store_management_user.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/drawer_list_item.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/View/Widgets/small_edir_member_item.dart';
import 'package:on_edir/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EdirDrawer extends StatefulWidget {
  const EdirDrawer({Key key}) : super(key: key);

  @override
  State<EdirDrawer> createState() => _EdirDrawerState();
}

class _EdirDrawerState extends State<EdirDrawer> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());
  MainController mainController = Get.put(MainController());

  List<SmallEdirMemberItem> edirList = [];

  var userService = Get.put(UserService());

  String uid = FirebaseAuth.instance.currentUser.uid;

  Widget topPart() => Container(
        color: const Color.fromARGB(101, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Obx(
                    () => edirPAgeController.currentEdir.value.img_url == ""
                        ? const CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.account_circle),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                edirPAgeController.currentEdir.value.img_url),
                          ),
                  ),
                  Spacer(),
                   Obx(()=>
                      edirPAgeController.currentEdir.value.eid != "" ?
                      QrImage(
                        backgroundColor: Colors.white,
                        data: edirPAgeController.currentEdir.value.eid,
                        version: QrVersions.auto,
                        size: 100.0,
                      ):const SizedBox()
                      ),
                    Spacer()
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 18),
              child: Obx(
                () => ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    title: Obx(() =>
                        edirPAgeController.currentEdir.value.edirName != ""
                            ? Text(
                                edirPAgeController.currentEdir.value.edirName,
                                style: const TextStyle(fontSize: 20),
                              )
                            : Text("Loading...".tr)),
                    subtitle: Obx(() =>
                        edirPAgeController.currentEdir.value.created_by != ""
                            ? Text(
                                "Created by".tr+edirPAgeController.currentEdir.value.created_by_name+"creat".tr,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 197, 197, 197)),
                              )
                            : Text("Loading...".tr)),
                    children: [
                      ...mainController.edirList.isNotEmpty
                          ? edirList
                          : [const Center(child: CircularProgressIndicator())],
                      const SizedBox(
                        height: 15,
                      ),
                      DrawerListItem(
                          text: "Add Edir".tr,
                          action: () {
                            Get.to(() => const MainPage());
                          },
                          icon: Icons.add)
                    ]),
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyEdirList();
  }

  getMyEdirList() async {
    // await userService.getEdirList();
    for (Edir edir in mainController.edirList) {
      edirList.add(SmallEdirMemberItem(
        imgUrl: edir.img_url,
        title: edir.edirName,
        onTap: () {
          edirPAgeController.setCurrentEdir(edir);
        },
        id: edir.eid,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            topPart(),
            const SizedBox(
              height: 10,
            ),
            
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "My Profile".tr,
                action: () => Get.to(() => const MyProfile()),
                icon: Icons.account_circle),
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "Edir Info".tr,
                action: () => Get.to(() =>
                    edirPAgeController.currentEdir.value.created_by == uid
                        ? const EdirInfoAdmin()
                        : EdirInfoUser()),
                icon: Icons.info),
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "Edir Members".tr,
                action: () => Get.to(() => const EdirMembersPage()),
                icon: Icons.group_outlined),
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "Edir Group Chat".tr,
                action: () => Get.to(() => const EdirGroupChat()),
                icon: Icons.group),
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "Payment".tr,
                action: () => Get.to(() =>
                    edirPAgeController.currentEdir.value.created_by ==
                            mainController.myInfo.value.uid
                        ? const PaymentAdmin()
                        : const PaymentUser()),
                icon: Icons.payment),
            const SizedBox(
              height: 5,
            ),
            DrawerListItem(
                text: "Store Management".tr,
                action: () => Get.to(() =>
                    edirPAgeController.currentEdir.value.created_by ==
                            mainController.myInfo.value.uid
                        ? const StoreManagementAdmin()
                        : const StoreManagemntUser()),
                icon: Icons.store),
             DrawerListItem(
                text: "Switch Language".tr,
                action: () => Get.locale == const Locale('am',"ET") ? Get.updateLocale(const Locale('en', 'BR')) : Get.updateLocale(const Locale('am',"ET")),
                icon: Icons.language),
            const SizedBox(
              height: 5,
            ),
            
          ]),
        ),
      ),
    );
  }
}
