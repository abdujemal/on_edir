import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/CreateEdir/create_edir_page.dart';
import 'package:on_edir/View/Pages/JoinEdir/join_edir_page.dart';
import 'package:on_edir/View/Widgets/big_btn.dart';
import 'package:on_edir/constants.dart';

class JCEdir extends StatelessWidget {
  const JCEdir({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigBtn(
              text: "Create Edir",
              icon: Icons.add,
              action: () {
                Get.to(() => const CreateEdirPage());
              }),
          const SizedBox(
            height: 100,
          ),
          BigBtn(
              text: "Join Edir",
              icon: Icons.join_inner,
              action: () {
                Get.to(() => const JoinEdirPage());
              })
        ],
      ),
    );
  }
}
