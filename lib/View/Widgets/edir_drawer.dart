import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/EdirGroupChat/edir_group_chat.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/edir_info_admin.dart';
import 'package:on_edir/View/Pages/EdirInfoUser/edir_info_user.dart';
import 'package:on_edir/View/Pages/EdirMembers/edir_members_page.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MyProfile/my_profile.dart';
import 'package:on_edir/View/Pages/PaymentAdmin/payment_admin.dart';
import 'package:on_edir/View/Widgets/drawer_list_item.dart';
import 'package:on_edir/constants.dart';

class EdirDrawer extends StatefulWidget {
  const EdirDrawer({Key key}) : super(key: key);

  @override
  State<EdirDrawer> createState() => _EdirDrawerState();
}

class _EdirDrawerState extends State<EdirDrawer> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  Widget topPart()=> Container(
    color: const Color.fromARGB(101, 0, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding:const EdgeInsets.only(left: 10.0),
          child: Obx(()=>
            edirPAgeController.currentEdir.value.img_url == "" ?
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Icon(Icons.account_circle),
            ):
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(edirPAgeController.currentEdir.value.img_url),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 18),
          child: ExpansionTile(
              tilePadding: const EdgeInsets.all(0),
              title: Obx(() => Text(
                edirPAgeController.currentEdir.value != null?
                edirPAgeController.currentEdir.value.edirName
                :"",
                style: const TextStyle(fontSize: 20),
              )),
              subtitle: Obx(()=> Text(
                edirPAgeController.currentEdir.value != null?
                "Created by ${edirPAgeController.currentEdir.value.created_by_name}"
                :"",
                style: const TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 197, 197, 197)),
              )),
              children: [
                const SizedBox(
                  height: 15,
                ),
                DrawerListItem(text: "Add Edir", action: () {}, icon: Icons.add)
              ]),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          topPart(),
          const SizedBox(
            height: 10,
          ),
          DrawerListItem(
              text: "My Profile",
              action: () =>
                Get.to(() => const MyProfile())
              ,
              icon: Icons.account_circle),
          const SizedBox(
            height: 5,
          ),
          DrawerListItem(
              text: "Edir Info",
              action: () => Get.to(() => EdirInfoUser()),
              icon: Icons.info),
          const SizedBox(
            height: 5,
          ),
          DrawerListItem(
              text: "Edir Members", action: ()=>Get.to(()=>const EdirMembersPage()), icon: Icons.group_outlined),
          const SizedBox(
            height: 5,
          ),
          DrawerListItem(
              text: "Edir Group Chat",
              action: () => Get.to(() => const EdirGroupChat()),
              icon: Icons.group),
          const SizedBox(
            height: 5,
          ),
          DrawerListItem(text: "Payment", action: ()=>Get.to(const PaymentAdmin()), icon: Icons.payment),
          const SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}
