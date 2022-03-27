import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/CreateEdir/create_edir_page.dart';
import 'package:on_edir/View/Pages/JoinEdir/join_edir_page.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/big_btn.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/constants.dart';

class JCEdir extends StatelessWidget {
  JCEdir({Key key}) : super(key: key);

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigBtn(
              text: "Create Edir",
              icon: Icons.add,
              action: () =>
              mainController.userInfoIsAvailable.value?
                Get.to(() => const CreateEdirPage()): MSGSnack(title: "Alert!", msg: "Loading", color: Colors.white).show()
              ),
          const SizedBox(
            height: 100,
          ),
          BigBtn(
              text: "Join Edir",
              icon: Icons.join_inner,
              action: () =>
              mainController.userInfoIsAvailable.value?
                Get.to(() => const JoinEdirPage()): MSGSnack(title: "Alert!", msg: "Loading", color: Colors.white).show()
              )
        ],
      ),
    );
  }
}
