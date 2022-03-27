import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/View/Widgets/sl_btn.dart';
import 'package:on_edir/View/Widgets/sl_input.dart';
import 'package:on_edir/constants.dart';

class SignUp extends StatelessWidget {
  // const Login({ Key? key }) : super(key: key);

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController userNameTC = TextEditingController();

  LSController lsController = Get.put(LSController());

  UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(()=>
                  lsController.pickedFile.value == File("") ?

                     CircleAvatar(
                      child: Icon(Icons.account_circle, size: 100),
                      radius: 50,
                    ):
                    CircleAvatar(
                      backgroundImage: FileImage(lsController.pickedFile.value),                         
                      radius: 50,
                    )
                  ),
                  Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                          color: whiteColor,
                          onPressed: ()async {
                            XFile imagexFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (imagexFile != null) {
                            File imageFile = File(imagexFile.path);

                            lsController.setPickedImage(imageFile);
                          } else {
                            MSGSnack msgSnack = MSGSnack(
                                title: "Alert!",
                                msg: "Image is not picked",
                                color: Colors.red);
                            msgSnack.show();
                          }
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: whiteColor,
                          )))
                ],
              ),
              SizedBox(height: 20),
              SLInput(
                controller: emailTC,
                keyboardType: TextInputType.emailAddress,
                title: 'Email',
                hint: 'abc@website.com',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                controller: userNameTC,
                keyboardType: TextInputType.text,
                title: 'User Name',
                hint: 'chala mola',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                  isObscure: true,
                  title: "Password",
                  hint: "*******",
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTC),
              const SizedBox(
                height: 15,
              ),
              SLInput(
                  isObscure: true,
                  title: "Confirm Password",
                  hint: "*******",
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmPasswordTC),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Obx(
          () => lsController.isLoading.value
              ? const CircularProgressIndicator()
              : SLBtn(
                  text: "Sign Up",
                  onTap: () {
                    if (_key.currentState.validate()) {
                      if (confirmPasswordTC.text == passwordTC.text) {
                        userService.signUpWEmailNPW(emailTC.text,
                            passwordTC.text, userNameTC.text, context);
                      } else {
                        MSGSnack msgSnack = MSGSnack(
                            title: "Alert!",
                            msg: "Please write the same password.",
                            color: Colors.red);
                        msgSnack.show();
                      }
                    }
                  },
                ),
        ),
      ],
    );
  }
}
