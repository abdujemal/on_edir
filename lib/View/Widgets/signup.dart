import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/View/Widgets/sl_btn.dart';
import 'package:on_edir/View/Widgets/sl_input.dart';
import 'package:on_edir/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController userNameTC = TextEditingController();

  LSController lsController = Get.put(LSController());

  UserService userService = Get.put(UserService());

  var userBioTC = TextEditingController();

  var userPhoneTC = TextEditingController();

  var userRsPhoneTC = TextEditingController();

  var userFamilyMembersTC = TextEditingController();

  var userNoOfFamilyMembersTC = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userBioTC.dispose();
    userFamilyMembersTC.dispose();
    userNameTC.dispose();
    userPhoneTC.dispose();
    userRsPhoneTC.dispose();
    userNoOfFamilyMembersTC.dispose();
    emailTC.dispose();
    passwordTC.dispose();
    confirmPasswordTC.dispose();
  }

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
                  Obx(() {
                    print(lsController.pickedFilePath.value);
                    return lsController.pickedFilePath.value == ""
                        ? CircleAvatar(
                            child: Icon(Icons.account_circle, size: 100),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(
                                File(lsController.pickedFilePath.value)),
                            radius: 50,
                          );
                  }),
                  Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                          color: whiteColor,
                          onPressed: () async {
                            XFile imagexFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                            if (imagexFile != null) {
                              File imageFile = File(imagexFile.path);

                              lsController.setPickedImage(imageFile.path);
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
                controller: userBioTC,
                keyboardType: TextInputType.text,
                title: 'User Bio',
                hint: 'I lova programing ...',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                controller: userPhoneTC,
                keyboardType: TextInputType.phone,
                title: 'User Phone',
                hint: '0976894790',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                controller: userRsPhoneTC,
                keyboardType: TextInputType.phone,
                title: 'Your Reserve PhoneNumber',
                hint: '0967584930',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                controller: userFamilyMembersTC,
                keyboardType: TextInputType.text,
                title: 'Your Family Members',
                hint: 'chala, Awol, ...',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                controller: userNoOfFamilyMembersTC,
                keyboardType: TextInputType.number,
                title: 'Number Your Family Members',
                hint: '5',
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
                    if (!_key.currentState.validate()) {
                      
                    }else if(lsController.pickedFilePath.value == ""){
                      MSGSnack msgSnack = MSGSnack(
                            title: "Alert!",
                            msg: "Please choose your profile photo.",
                            color: Colors.red);
                        msgSnack.show();
                    }else if(confirmPasswordTC.text != passwordTC.text){
                      MSGSnack msgSnack = MSGSnack(
                            title: "Alert!",
                            msg: "Please write the same password.",
                            color: Colors.red);
                        msgSnack.show();
                    }else{
                      userService.signUpWEmailNPW(
                            File(lsController.pickedFilePath.value),
                            emailTC.text,
                            userNameTC.text,
                            userBioTC.text,
                            userPhoneTC.text,
                            userRsPhoneTC.text,
                            userFamilyMembersTC.text,
                            userNoOfFamilyMembersTC.text,
                            passwordTC.text,
                            context);
                    }
                  },
                ),
        ),
      ],
    );
  }
}
