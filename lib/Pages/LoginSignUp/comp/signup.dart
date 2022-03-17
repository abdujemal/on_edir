import 'package:flutter/material.dart';
import 'package:on_edir/Pages/LoginSignUp/comp/sl_btn.dart';
import 'package:on_edir/pages/LoginSignUp/comp/sl_input.dart';

class SignUp extends StatelessWidget {
  // const Login({ Key? key }) : super(key: key);

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  

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
                  title: "Password",
                  hint: "*******",
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTC),
              const SizedBox(
                height: 15,
              ),
              SLInput(
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
        SLBtn(
          text: "Sign Up",
          onTap: () {
            if(_key.currentState!.validate()){
              
            }
          },
        ),
      ],
    );
  }
}
