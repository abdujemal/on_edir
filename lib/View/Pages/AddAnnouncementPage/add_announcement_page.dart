import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/AddAnnouncementPage/controller/add_announcement_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class AddAnnouncement extends StatefulWidget {
  const AddAnnouncement({Key key}) : super(key: key);

  @override
  State<AddAnnouncement> createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  var titleTc = TextEditingController();

  var descriptionTc = TextEditingController();

  UserService userService = Get.put(UserService());

  AddAnnouncementController addAnnouncementController =
      Get.put(AddAnnouncementController());

  GlobalKey<FormState> _key = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleTc.dispose();
    descriptionTc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text("Announcement Form"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInput(
                      controller: titleTc,
                      hint: "Announcement Title",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonInput(
                    maxLines: 6,
                      controller: descriptionTc,
                      hint: "Announcement Description",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => addAnnouncementController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CommonBtn(
                            text: "Add",
                            action: () {
                              if (_key.currentState.validate()) {
                                userService.addAnnouncement(
                                    titleTc.text, descriptionTc.text, context);
                              }
                            }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
