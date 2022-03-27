
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/EdirInfoUser/controller/edir_info_user_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/edir_info_item.dart';
import 'package:on_edir/constants.dart';

class EdirInfoUser extends StatefulWidget {
  EdirInfoUser({
    Key key,
  }) : super(key: key);

  @override
  State<EdirInfoUser> createState() => _EdirInfoUserState();
}

class _EdirInfoUserState extends State<EdirInfoUser> {
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  EdirInfoUserController edirInfoUser = Get.put(EdirInfoUserController());

  UserService userService = Get.put(UserService());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addAllOptions();
  }

  addAllOptions()async{
    edirInfoUser.options.value = await userService.getOptionsUser(edirPAgeController.currentEdir.value.eid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Edir Info"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 10,),
            CircleAvatar(backgroundImage: NetworkImage(edirPAgeController.currentEdir.value.img_url),radius: 70,),
            const SizedBox(height: 10,),
            EdirInfoItem(title: "Edir Name", value: edirPAgeController.currentEdir.value.edirName),
            EdirInfoItem(title: "Edir Bio", value: edirPAgeController.currentEdir.value.edirBio),
            EdirInfoItem(title: "Edir Address", value: edirPAgeController.currentEdir.value.edirAddress),
            EdirInfoItem(title: "Amount Of Money", value: edirPAgeController.currentEdir.value.amountOfMoney),
            EdirInfoItem(title: "Duration Of Payment", value: edirPAgeController.currentEdir.value.durationOfPayment),

            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Edir Rules And Regulations",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(edirPAgeController.currentEdir.value.rules)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Bank Account Options",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Obx(()=> edirInfoUser.options.isNotEmpty ? Column(children: edirInfoUser.options.map((option) => ListTile(trailing: const Icon(Icons.payment), title: Text(option.bank), subtitle: Text(option.account),)).toList()) : Column(children: [],)),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
