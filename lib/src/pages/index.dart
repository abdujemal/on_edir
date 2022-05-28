import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  UserService userService = Get.put(UserService());

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  MainController mainController = Get.put(MainController());

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edirPAgeController.setIsTokenLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Video Conference".tr,
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          const Icon(
            Icons.video_call,
            size: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                    child:
                        Obx(
                          () => !edirPAgeController.isTokenLoading.value?
                        ElevatedButton(
                  onPressed: () async {
                    if (edirPAgeController.currentEdir.value.created_by ==
                        mainController.myInfo.value.uid) {
                      if (await userService.saveAccessToken()) {
                        onJoin();
                      }
                    } else {
                      if (await userService.getAcccessTokenFromFirebase()) {
                        onJoin();
                      }
                    }
                  },
                  child: Text(edirPAgeController.currentEdir.value.created_by ==
                          mainController.myInfo.value.uid
                      ? 'Start'.tr
                      : 'Join'.tr),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                )
                    : Center(child: const CircularProgressIndicator()),
                    ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
            channelName: edirPAgeController.currentEdir.value.eid,
            role: ClientRole.Broadcaster),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
