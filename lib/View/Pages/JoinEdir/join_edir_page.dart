import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/JoinEdir/controller/join_edir_controller.dart';
import 'package:on_edir/View/Pages/QrScannerPage/qr_scanner_page.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class JoinEdirPage extends StatefulWidget {
  const JoinEdirPage({Key? key}) : super(key: key);

  @override
  State<JoinEdirPage> createState() => _JoinEdirPageState();
}

class _JoinEdirPageState extends State<JoinEdirPage> {
  TextEditingController _edirCodeController = TextEditingController();

  UserService userService = Get.put(UserService());

  JoinEdirController joinEdirController = Get.put(JoinEdirController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _edirCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Join Edir".tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              IconButton(icon:const Icon(Icons.qr_code),onPressed:()=>Get.to(()=>const QrScannerPage())),
              CommonInput(
                  controller: _edirCodeController,
                  hint: "Edir Code".tr,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 35,
              ),
              Obx(
                () => joinEdirController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CommonBtn(
                        action: () {
                          if (_edirCodeController.text.isNotEmpty) {
                            userService.joinEdir(
                              
                                _edirCodeController.text, "User", context, "New");
                          }
                        },
                        text: "Join".tr,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
