import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/constants.dart';

class CreateEdirPage extends StatefulWidget {
  const CreateEdirPage({Key key}) : super(key: key);

  @override
  State<CreateEdirPage> createState() => _CreateEdirPageState();
}

class _CreateEdirPageState extends State<CreateEdirPage> {
  TextEditingController edirNameTc = TextEditingController();
  TextEditingController edirRulesTc = TextEditingController();
  TextEditingController edirAddressTc = TextEditingController();

  UserService userService = Get.put(UserService());

  CreateEdirController createEdirController = Get.put(CreateEdirController());

  @override
  void dispose() {
    // TODO: implement dispose
    edirAddressTc.dispose();
    edirRulesTc.dispose();
    edirNameTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Create Edir"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Obx(() => createEdirController.pickedfile.value != File("")
                        ? Image.file(
                            createEdirController.pickedfile.value,
                            width: 100,
                            height: 100,
                          )
                        : const Icon(Icons.image, size: 150)),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                        onPressed: () async {
                          XFile imagexFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (imagexFile != null) {
                            File imageFile = File(imagexFile.path);

                            createEdirController.setImage(imageFile);
                          } else {
                            MSGSnack msgSnack = MSGSnack(
                                title: "Alert!",
                                msg: "Image is not picked",
                                color: Colors.red);
                            msgSnack.show();
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo_sharp,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonInput(
                    controller: edirNameTc,
                    hint: "Edir Name",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                CommonInput(
                    controller: edirAddressTc,
                    hint: "Edir Address",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                CommonInput(
                  controller: edirRulesTc,
                  hint: "Edir Rules and Regulations",
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => createEdirController.isLoading.value
                      ? CircularProgressIndicator()
                      : CommonBtn(
                          text: "Create Edir",
                          action: () {
                            userService.createEdir(
                                edirNameTc.text,
                                edirAddressTc.text,
                                edirRulesTc.text,
                                createEdirController.pickedfile.value,
                                context);
                          }),
                ),
                SizedBox(
                  height: 30,
                )
              ]),
        ),
      ),
    );
  }
}
