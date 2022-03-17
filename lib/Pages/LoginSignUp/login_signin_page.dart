
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Pages/LoginSignUp/comp/login.dart';
import 'package:on_edir/Pages/LoginSignUp/comp/signup.dart';
import 'package:on_edir/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:on_edir/constants.dart';


class LogInSignInPage extends StatefulWidget {
  const LogInSignInPage({Key? key}) : super(key: key);

  @override
  _LogInSignInPageState createState() => _LogInSignInPageState();
}

class _LogInSignInPageState extends State<LogInSignInPage> {
  LSController lsController = Get.put(LSController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90,),
                Image.asset(
                  "assets/logo.png",
                  width: 140,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Online Edir Application",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx((() => lsController.isLogin.value ? Login() : SignUp())),
                SizedBox(height: 40,),
                Obx(
                  () =>        Text(
                      lsController.isLogin.value ?
                      "New to this app?":"Already have an account?",
                      style: TextStyle(color: textColor, fontSize: 12),
                    )
                  
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                    onTap: () {
                      if (lsController.isLogin.value) {
                        lsController.setIsLogin(false);
                      } else {
                        lsController.setIsLogin(true);
                      }
                    },
                    child: Obx(()=> Text(
                      lsController.isLogin.value ?
                      "Create an Account":
                      "Already have an account",
                      style: TextStyle(
                          color: whiteColor, fontWeight: FontWeight.bold),
                    ))),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
