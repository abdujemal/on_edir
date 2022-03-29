import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/AddStoreItemPage/constroller/add_store_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/constants.dart';

class AddStoreItem extends StatefulWidget {
  const AddStoreItem({Key key}) : super(key: key);

  @override
  State<AddStoreItem> createState() => _AddStoreItemState();
}

class _AddStoreItemState extends State<AddStoreItem> {
  var itemNameTc = TextEditingController();

  var itemDescriptionTc = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  UserService userService = Get.put(UserService());

  AddStoreController addStoreController = Get.put(AddStoreController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Add Store Form"),
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
                Stack(
                  children: [
                    Obx(() => addStoreController.filePath.value == ""
                        ? const Icon(
                            Icons.image,
                            size: 100,
                          )
                        : Image.file(
                            File(addStoreController.filePath.value),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                        onPressed: () async {
                          XFile xFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (xFile != null) {
                            addStoreController.setFilePath(xFile.path);
                          } else {
                            MSGSnack msgSnack = MSGSnack(
                                title: "Alert!",
                                msg: "you have not chosen an image",
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
                  height: 10,
                ),
                CommonInput(
                    controller: itemNameTc,
                    hint: "Item Name",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                  controller: itemDescriptionTc,
                  hint: "Item Description",
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => addStoreController.isLoading.value
                    ? const CircularProgressIndicator()
                    : CommonBtn(
                        text: "Save",
                        action: () {
                          if (!_key.currentState.validate()) {
                          } else if (addStoreController.filePath.value == "") {
                            MSGSnack msgSnack = MSGSnack(
                                title: "Alert!",
                                msg: "image is blank.",
                                color: Colors.red);
                            msgSnack.show();
                          } else {
                            userService.addStoreItem(
                                itemNameTc.text,
                                itemDescriptionTc.text,
                                File(addStoreController.filePath.value),
                                context);
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}