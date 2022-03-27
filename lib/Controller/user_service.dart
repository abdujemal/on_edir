import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:path_provider/path_provider.dart';

import '../View/Pages/LoginSignUp/controller/l_s_controller.dart';

class UserService extends GetxService {
  LSController slcontroller = Get.put(LSController());

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

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

  joinEdir(String edirId) async{
    // Map<String, Object> joiningEdir = {
    //   "edirName": edirName,
    //   "edirAddress": address,
    //   "uid": auth.currentUser.uid,
    //   "user_img_url": url
    // };

    try{
    // await database
    //       .ref()
    //       .child("JoinedEdir")
    //       .child(edirId)
    //       .child(auth.currentUser.uid)
    //       .update(joiningEdir);
    }catch(e){

    }
  }

  createEdir(String edirName, String address, String rules, File file,BuildContext context) async {
    CreateEdirController controller = Get.put(CreateEdirController());

    DatabaseReference ref = database.ref().child("Edirs").push();

    controller.setIsLoading(true);

    String url = await uploadImage("EdirImage/${ref.key.toString()}.png", file);

    Map<String, Object> newEdir = {
      "eid": ref.key.toString(),
      "edirName": edirName,
      "edirAddress": address,
      "rules": rules,
      "img_url": url
    };

    try {
      await ref.update(newEdir);
      
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

  signUpWEmailNPW(String email, String password, String UserName,
      BuildContext context) async {
    try {
      slcontroller.setIsLoading(true);

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) async {
        Map<String, Object> map = {
          "email": email,
          "userName": UserName,
          "uid": auth.currentUser.uid
        };

        await database
            .ref()
            .child("Users")
            .child(auth.currentUser.uid)
            .update(map);
        slcontroller.setIsLoading(false);
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
