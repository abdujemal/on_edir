import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/View/Widgets/sl_btn.dart';
import 'package:on_edir/View/Widgets/sl_input.dart';
import 'package:on_edir/constants.dart';

class Login extends StatelessWidget {
  // const Login({ Key? key }) : super(key: key);

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

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
                  isObscure: true,
                  title: "Password",
                  hint: "*******",
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTC),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (emailTC.text.isNotEmpty) {
              userService.forgetPassword(emailTC.text, context);
            } else {
              MSGSnack msgSnack = MSGSnack(
                  title: "Alert!",
                  msg: "Please write your email.",
                  color: Colors.red);
              msgSnack.show();
            }
          },
          child: GestureDetector(
            onTap: () {},
            child: Text(
              "Forget password?",
              style: TextStyle(color: textColor),
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        Obx(()=>
          lsController.isLoading.value ?
          const CircularProgressIndicator():
           SLBtn(
            text: "Log In",
            onTap: () {
              if (_key.currentState.validate()) {
                userService.loginWEmailNPW(
                    emailTC.text, passwordTC.text, context);
              }
            },
          ),
        ),
      ],
    );
  }
}
