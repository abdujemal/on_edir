import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MyProfile/controller/my_profile_controller.dart';
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

  MainController mainController = Get.put(MainController());

  MyProfileController myProfileController = Get.put(MyProfileController());

  UserService userService = Get.put(UserService());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameTc.text = mainController.myInfo.value.userName;
    userBioTc.text = mainController.myInfo.value.userBio;
    emailAddressTc.text = mainController.myInfo.value.email;
    phoneNumberTc.text = mainController.myInfo.value.userPhone;
    reservePhoneNumberTc.text = mainController.myInfo.value.userRsPhone;
    familyMembersTc.text = mainController.myInfo.value.familyMembers;
    numOfFamilyMembersTc.text = mainController.myInfo.value.noOfFamily;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameTc.dispose();
    userBioTc.dispose();
    emailAddressTc.dispose();
    phoneNumberTc.dispose();
    reservePhoneNumberTc.dispose();
    familyMembersTc.dispose();
    numOfFamilyMembersTc.dispose();
  }

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
                    Obx(
                      () => mainController.myInfo.value.img_url != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  mainController.myInfo.value.img_url),
                              radius: 50,
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.account_circle, size: 100),
                              radius: 50,
                            ),
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
                myProfileController.isLoading.value ?
                const CircularProgressIndicator():
                CommonBtn(
                    text: "Save Changes",
                    action: () {
                      if (profile_key.currentState.validate()) {
                        userService.updateUserInfo(
                            emailAddressTc.text,
                            userNameTc.text,
                            userBioTc.text,
                            phoneNumberTc.text,
                            reservePhoneNumberTc.text,
                            familyMembersTc.text,
                            numOfFamilyMembersTc.text,
                            context);
                      }
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
