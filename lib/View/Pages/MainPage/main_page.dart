import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/View/Pages/LoginSignUp/login_signin_page.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading:  Obx(()=>
            !mainController.userInfoIsAvailable.value ?
               IconButton(
                icon: const Icon(FontAwesomeIcons.circle),
                onPressed: ()=>
                  userService.getUserInfo(),
              ):
              const SizedBox(),
            ),
            title: const Text("My Edir List"),
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
          body: JCEdir()),
    );
  }
}
