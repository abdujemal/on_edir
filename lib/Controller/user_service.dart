import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/Model/my_info.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Pages/JoinEdir/controller/join_edir_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Pages/MyProfile/controller/my_profile_controller.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';

import '../View/Pages/LoginSignUp/controller/l_s_controller.dart';

class UserService extends GetxService {
  LSController slcontroller = Get.put(LSController());

  MainController mainController = Get.put(MainController());

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  CreateEdirController createEdirController = Get.put(CreateEdirController());

  JoinEdirController joinEdirController = Get.put(JoinEdirController());

  MyProfileController myProfileController = Get.put(MyProfileController());

  updateUserInfo(
      String email,
      String userName,
      String userBio,
      String userPhone,
      String userRsPhone,
      String familyMembers,
      String noOfFamily,
      BuildContext context) async {
    try {
      myProfileController.setIsLoading(true);

      Map<String, Object> map = {
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
      myProfileController.setIsLoading(false);

      MSGSnack msgSnack = MSGSnack(
          title: "Success!",
          msg: "You have successfully updated your profile.",
          color: Colors.green);
      msgSnack.show();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false);
    } catch (e) {
      myProfileController.setIsLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  getEdir(String eid) async {
    try {
      DatabaseEvent databaseEvent =
          await database.ref().child("Edirs").child(eid).once();
      if (databaseEvent.snapshot.exists) {
        Map<dynamic, dynamic> data = databaseEvent.snapshot.value;
        Edir edirModel = Edir.fromFirebaseMap(data);
        edirPAgeController.setCurrentEdir(edirModel);
      }
    } catch (e) {
      MSGSnack msgSnack =
          MSGSnack(title: "!Error", msg: e.toString(), color: Colors.red);
      msgSnack.show();
    }
  }

  Future<List<Edir>> getEdirList() async {
    DatabaseReference ref = database.ref();

    List<Edir> edirList = [];

    try {
      DatabaseEvent databaseEvent =
          await ref.child("MyEdirLists").child(auth.currentUser.uid).once();
      if (databaseEvent.snapshot.exists) {
        Map<dynamic, dynamic> edirData =
            Map<dynamic, dynamic>.from(databaseEvent.snapshot.value);
        List<String> edirIds = [];
        for (String id in edirData.keys) {
          DatabaseEvent edirEvents = await ref.child("Edirs").child(id).once();
          Map<dynamic, dynamic> edirData =
              Map<dynamic, dynamic>.from(edirEvents.snapshot.value);
          Edir edirModel = Edir.fromFirebaseMap(edirData);
          mainController.edirList.add(edirModel);
        }
      }
    } catch (e) {
      MSGSnack msgSnack =
          MSGSnack(title: "!Error this", msg: e.toString(), color: Colors.red);
      msgSnack.show();
    }

    return edirList;
  }

  Future<bool> getUserInfo() async {
    try {
      DatabaseEvent databaseEvent = await database
          .ref()
          .child("Users")
          .child(auth.currentUser.uid)
          .once();

      Map<dynamic, dynamic> data =
          databaseEvent.snapshot.value as Map<dynamic, dynamic>;

      MyInfo myInfo = MyInfo.fromFirebaseMap(data);

      mainController.setMyInfo(myInfo);
      mainController.setUserInfoIsAvailable(true);
    } catch (e) {
      MSGSnack msgSnack =
          MSGSnack(title: "!Error", msg: e.toString(), color: Colors.red);
      msgSnack.show();
      mainController.setUserInfoIsAvailable(true);
    }
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

  joinEdir(String edirId, String position, BuildContext context) async {
    EdirMember edirMember = EdirMember(mainController.myInfo.value.img_url,
        position, auth.currentUser.uid, mainController.myInfo.value.userName);

    Map<String, Object> joiningUser = edirMember.tofirebaseMap(edirMember);
    Map<String, Object> myEdirListItem = {"eid": edirId};

    try {
      joinEdirController.setIsLoading(true);

      await database
          .ref()
          .child("EdirMembers")
          .child(edirId)
          .child(auth.currentUser.uid)
          .update(joiningUser);
      await database
          .ref()
          .child("MyEdirLists")
          .child(auth.currentUser.uid)
          .child(edirId)
          .update(myEdirListItem);

      MSGSnack msgSnack = MSGSnack(
          title: "!Success",
          msg: position == "Admin"
              ? "You have successfully created your edir."
              : "You have successfully joined your edir.",
          color: Colors.green);
      msgSnack.show();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => EdirPage(
                    edirId: edirId,
                  )));

      joinEdirController.setIsLoading(false);
      createEdirController.setIsLoading(false);
    } catch (e) {
      MSGSnack msgSnack =
          MSGSnack(title: "!Error", msg: e.toString(), color: Colors.red);
      msgSnack.show();
    }
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
    DatabaseReference ref = database.ref().child("Edirs").push();

    createEdirController.setIsLoading(true);

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
      "created_by": auth.currentUser.uid,
      "created_by_name": mainController.myInfo.value.userName
    };

    try {
      await ref.update(newEdir);

      await database
          .ref()
          .child("PaymentOptions")
          .child(ref.key.toString())
          .update(options);

      await joinEdir(ref.key.toString(), "Admin", context);
    } catch (e) {
      createEdirController.setIsLoading(false);
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
