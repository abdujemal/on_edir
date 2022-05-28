import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/View/Pages/CreateEdir/create_edir_page.dart';
import 'package:on_edir/View/Pages/JoinEdir/join_edir_page.dart';
import 'package:on_edir/View/Pages/LoginSignUp/login_signin_page.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/edir_list_widget.dart';
import 'package:on_edir/View/Widgets/join_create_edir.dart';
import 'package:on_edir/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserService userService = Get.put(UserService());

  MainController mainController = Get.put(MainController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userService.getUserInfo();
    userService.getEdirList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Obx(
            () => !mainController.userInfoIsAvailable.value
                ? IconButton(
                    icon: const Icon(FontAwesomeIcons.circle),
                    onPressed: () => userService.getUserInfo(),
                  )
                : const SizedBox(),
          ),
          title: Text("My Edir List".tr),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LogInSignInPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton:  Obx(()=>
          mainController.edirList.value.isEmpty ?
          const SizedBox():
           SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                onTap: ()=>Get.to(()=>const CreateEdirPage()),
                child: const Icon(Icons.add),
                label: "Create Edir".tr
              ),
              SpeedDialChild(
                onTap: ()=>Get.to(()=>const JoinEdirPage()),
                child: const Icon(Icons.join_full_outlined),
                label: "Join Edir".tr,
              )
            ],
          ),
        ),
        body: Obx(
          () => mainController.edirList.value.isEmpty
              ? JCEdir()
              : const EdirListWidget(),
        ),
      ),
    );
  }
}
