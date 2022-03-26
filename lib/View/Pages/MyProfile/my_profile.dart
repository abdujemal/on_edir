import 'package:flutter/material.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController userNameTc = TextEditingController();

  TextEditingController userBioTc = TextEditingController();

  TextEditingController emailAddressTc = TextEditingController();

  TextEditingController phoneNumberTc = TextEditingController();

  TextEditingController reservePhoneNumberTc = TextEditingController();

  TextEditingController familyMembersTc = TextEditingController();

  TextEditingController numOfFamilyMembersTc = TextEditingController();

  GlobalKey<FormState> profile_key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("My Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: profile_key,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.account_circle, size: 100),
                      radius: 50,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton(
                          color: whiteColor,
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo,
                              color: whiteColor,
                              
                            )))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonInput(
                    controller: userNameTc,
                    hint: "User Name",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                    controller: userBioTc,
                    hint: "User Bio",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                    controller: emailAddressTc,
                    hint: "Email Address",
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                  controller: phoneNumberTc,
                  hint: "Your Phone Number",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                  controller: reservePhoneNumberTc,
                  hint: "Your Reserve Phone Number",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                  controller: familyMembersTc,
                  hint: "Your Family Members",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonInput(
                  controller: numOfFamilyMembersTc,
                  hint: "Number of family Members",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonBtn(
                    text: "Save Changes",
                    action: () {
                      if (profile_key.currentState.validate()) {}
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
