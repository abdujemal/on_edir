import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/Model/my_info.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:path_provider/path_provider.dart';

import '../View/Pages/LoginSignUp/controller/l_s_controller.dart';

class UserService extends GetxService {
  LSController slcontroller = Get.put(LSController());

  MainController mainController = Get.put(MainController());

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Edir>> checkEdirList() async {
    DatabaseReference ref = database.ref().child("Edirs");
    List<Edir> edirList = [];
    DatabaseEvent databaseEvent = await ref.once();
    if (databaseEvent.snapshot.exists) {
      Map<dynamic, dynamic> edirsData =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>;
      // ignore: missing_return
      edirsData.map((key, value) {
        Map<dynamic, dynamic> edirItem = Map<dynamic, dynamic>.from(value);
        Edir edirModel = Edir.fromFirebaseMap(edirItem);
        if (edirItem["created_by"].toString() == auth.currentUser.uid) {
          edirList.add(edirModel);
        }
      });
    }
    return edirList;
  }

  getUserInfo() async {
    DatabaseEvent databaseEvent =
        await database.ref().child("Users").child(auth.currentUser.uid).once();

    Map<dynamic, dynamic> data =
        databaseEvent.snapshot.value as Map<dynamic, dynamic>;

    MyInfo myInfo = MyInfo.fromFirebaseMap(data);

    mainController.setMyInfo(myInfo);
  }

  Future<String> uploadImage(String path, File file) async {
    try {
      UploadTask uploadTask = storage.ref(path).putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;

      return taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      MSGSnack msgSnack = MSGSnack(
          title: "Error on Uploading Image!",
          msg: e.toString(),
          color: Colors.red);
      msgSnack.show();
    }
  }

  joinEdir(String edirId) async {
    // Map<String, Object> joiningEdir = {
    //   "edirName": edirName,
    //   "edirAddress": address,
    //   "uid": auth.currentUser.uid,
    //   "user_img_url": url
    // };

    try {
      // await database
      //       .ref()
      //       .child("JoinedEdir")
      //       .child(edirId)
      //       .child(auth.currentUser.uid)
      //       .update(joiningEdir);
    } catch (e) {}
  }

  createEdir(
      Map<String, Object> options,
      String edirName,
      String rules,
      String edirAddress,
      String edirBio,
      String durationOfPayment,
      String amountOfMoney,
      File file,
      BuildContext context) async {
    CreateEdirController controller = Get.put(CreateEdirController());

    DatabaseReference ref = database.ref().child("Edirs").push();

    controller.setIsLoading(true);

    String url = await uploadImage("EdirImage/${ref.key.toString()}.png", file);

    Map<String, Object> newEdir = {
      "eid": ref.key.toString(),
      "edirName": edirName,
      "edirAddress": edirAddress,
      "edirBio": edirBio,
      "durationOfPayment": durationOfPayment,
      "amountOfMoney": amountOfMoney,
      "rules": rules,
      "img_url": url,
      "created_by": auth.currentUser.uid
    };

    try {
      await ref.update(newEdir);

      await database
          .ref()
          .child("PaymentOptions")
          .child(ref.key.toString())
          .update(options);

      Navigator.push(context, MaterialPageRoute(builder: (ctx) => EdirPage()));
      controller.setIsLoading(false);
    } catch (e) {
      controller.setIsLoading(false);
      MSGSnack msgSnack = MSGSnack(
          title: "Error on uploading data!",
          msg: e.toString(),
          color: Colors.red);
      msgSnack.show();
    }
  }

  signUpWEmailNPW(
      File file,
      String email,
      String userName,
      String userBio,
      String userPhone,
      String userRsPhone,
      String familyMembers,
      String noOfFamily,
      String password,
      BuildContext context) async {
    try {
      slcontroller.setIsLoading(true);

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) async {
        String imgUrl =
            await uploadImage("Users/${auth.currentUser.uid}.png", file);

        Map<String, Object> map = {
          "img_url": imgUrl,
          "email": email,
          "userName": userName,
          "userBio": userBio,
          "userPhone": userPhone,
          "userRsPhone": userRsPhone,
          "familyMembers": familyMembers,
          "noOfFamily": noOfFamily,
          "uid": auth.currentUser.uid
        };

        await database
            .ref()
            .child("Users")
            .child(auth.currentUser.uid)
            .update(map);
        slcontroller.setIsLoading(false);

        MSGSnack msgSnack = MSGSnack(
            title: "Success!",
            msg: "You have successfully Registered.",
            color: Colors.green);
        msgSnack.show();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false);
      });
    } catch (e) {
      slcontroller.setIsLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  loginWEmailNPW(String email, String password, BuildContext context) async {
    try {
      slcontroller.setIsLoading(true);

      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) async {
        slcontroller.setIsLoading(false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);
      });
    } catch (e) {
      slcontroller.setIsLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  signInWGoogleAccount() {}

  forgetPassword(String email, BuildContext context) async {
    try {
      slcontroller.setIsLoading(true);
      await auth.sendPasswordResetEmail(email: email);

      MSGSnack successMSG = MSGSnack(
          title: "Success!",
          msg: "We successfully sent you an email.",
          color: Colors.green);
      successMSG.show();

      slcontroller.setIsLoading(false);
    } catch (e) {
      slcontroller.setIsLoading(false);

      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }
}
