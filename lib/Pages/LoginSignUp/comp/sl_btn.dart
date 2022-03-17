import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:on_edir/constants.dart';

class SLBtn extends StatelessWidget {
  String text;
  void Function() onTap;
  SLBtn({Key? key, required this.text, required this.onTap}) : super(key: key);

  LSController lsController = Get.put(LSController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> 
      lsController.isLoading.value ?
      const CircularProgressIndicator():
      InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              gradient: orangeGradient, borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
        ),
      ),
    );
  }
}
