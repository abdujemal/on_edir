import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/send_notification.dart';
import 'package:on_edir/Model/announcement.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/Model/chat.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/Model/edir_member.dart';
import 'package:on_edir/Model/my_info.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/Model/store.dart';
import 'package:on_edir/Model/store_item_request.dart';
import 'package:on_edir/View/Pages/AddAnnouncementPage/controller/add_announcement_controller.dart';
import 'package:on_edir/View/Pages/AddStoreItemPage/constroller/add_store_controller.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Pages/JoinEdir/controller/join_edir_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/View/Pages/MyProfile/controller/my_profile_controller.dart';
import 'package:on_edir/View/Pages/StoreDetail/controller/store_detail_controller.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:http/http.dart' as http;
import '../View/Pages/LoginSignUp/controller/l_s_controller.dart';

class UserService extends GetxService {
  LSController slcontroller = Get.put(LSController());

  MainController mainController = Get.put(MainController());

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  EdirInfoController edirInfoController = Get.put(EdirInfoController());

  CreateEdirController createEdirController = Get.put(CreateEdirController());

  JoinEdirController joinEdirController = Get.put(JoinEdirController());

  MyProfileController myProfileController = Get.put(MyProfileController());

  StoreDetailController storeDetailController =
      Get.put(StoreDetailController());

  AddAnnouncementController addAnnouncementController =
      Get.put(AddAnnouncementController());

  AddStoreController addStoreController = Get.put(AddStoreController());

  Future<String?> uploadImage(String path, File file) async {
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
    return null;
  }

  sendStoreRentRequest(String reason, String dateOfReturn, BuildContext context,
      String p_img, String pid, String p_name) async {
    try {
      storeDetailController.setIsLoading(true);

      DateTime dt = DateTime.now();

      DatabaseReference ref =
          database.ref().child("StoreItemRentRequest").push();

      StoreItemRequest storeItemRequest = StoreItemRequest(
          edirPAgeController.currentEdir.value.created_by,
          "${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute}",
          dateOfReturn,
          edirPAgeController.currentEdir.value.eid,
          p_img,
          pid,
          reason,
          ref.key.toString(),
          "Pending",
          auth.currentUser!.uid,
          p_name);

      await ref.update(storeItemRequest.toFirebaseMap(storeItemRequest));

      SendNotification sendNotification = SendNotification(
          title: "Store Rent Request",
          body: "${mainController.myInfo.value.userName} has sent a request.",
          topic: edirPAgeController.currentEdir.value.created_by);

      sendNotification.send();

      storeDetailController.setIsLoading(false);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  EdirPage(edirId: edirPAgeController.currentEdir.value.eid)),
          (route) => false);
    } catch (e) {
      storeDetailController.setIsLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  Future<void> setStoreRequiestState(
      StoreItemRequest storeItemRequest, String state) async {
    try {
      DatabaseReference ref = database
          .ref()
          .child("StoreItemRentRequest")
          .child(storeItemRequest.srid);
      await ref.child("state").set(state);

      SendNotification sendNotification = SendNotification(
          title: "Store Request",
          body: "Your ${storeItemRequest.p_name} request is $state",
          topic: storeItemRequest.uid);

      sendNotification.send();
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  Future<bool> deleteAccessTokenFromFirebase() async {
    try {
      await database
          .ref()
          .child("Edirs")
          .child(edirPAgeController.currentEdir.value.eid)
          .child("access_token")
          .remove();

      return true;
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
      return false;
    }
  }

  Future<bool> saveAccessToken() async {
    try {
      edirPAgeController.isTokenLoading(true);

      String? token = await getAccessTokenFromServer(
          edirPAgeController.currentEdir.value.eid);

      if (token != null) {
        await database
            .ref()
            .child("Edirs")
            .child(edirPAgeController.currentEdir.value.eid)
            .child("access_token")
            .set(token);

        edirPAgeController.setAccessToken(token);

        DatabaseEvent events = await database
            .ref()
            .child("EdirMembers")
            .child(edirPAgeController.currentEdir.value.eid)
            .once();

        Map<dynamic, dynamic> data =
            events.snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          SendNotification sendNotification = SendNotification(
              title: "Video Conference",
              body:
                  "${edirPAgeController.currentEdir.value.edirName} had started video conference.",
              topic: value['uid']);

          sendNotification.send();
        });

        edirPAgeController.setIsTokenLoading(false);

        return true;
      } else {
        MSGSnack errorMSG = MSGSnack(
            color: Colors.red,
            title: "Error!",
            msg: "token is null. try again!");
        errorMSG.show();

        edirPAgeController.setIsTokenLoading(false);
        return false;
      }
    } catch (e) {
      edirPAgeController.isTokenLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
      return false;
    }
  }

  Future<bool> getAcccessTokenFromFirebase() async {
    edirPAgeController.setIsTokenLoading(true);
    try {
      DatabaseEvent event = await database
          .ref()
          .child("Edirs")
          .child(edirPAgeController.currentEdir.value.eid)
          .child("access_token")
          .once();

      if (event.snapshot.exists) {
        print(event.snapshot.value);
        edirPAgeController.setAccessToken(event.snapshot.value.toString());
        edirPAgeController.setIsTokenLoading(false);
        return true;
      } else {
        edirPAgeController.setIsTokenLoading(false);
        MSGSnack errorMSG = MSGSnack(
            color: Colors.red,
            title: "Error!",
            msg: "Video chat is not started.");
        errorMSG.show();
        return false;
      }
    } catch (e) {
      edirPAgeController.setIsTokenLoading(false);
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
      return false;
    }
  }

  Future<String?> getAccessTokenFromServer(String ChannelName) async {
    final getUrl =
        'https://morning-beach-95074.herokuapp.com/access_token?channelName=${ChannelName}';

    final response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      // on success do st
      var res = response.body;
      print(jsonDecode(res)["token"]);
      return jsonDecode(res)["token"];
    } else {
      // on failure do sth
      return null;
    }
  }

  editStore(
      String type, String path, String currentQuantity, String img_url) async {
    // increase, decrease and delete a qunatity of store item
    print(img_url);
    String imgpath = img_url
        .replaceAll(
            "https://firebasestorage.googleapis.com/v0/b/onedir-42e14.appspot.com/o/",
            "")
        .split("?")[0]
        .replaceAll("%2F", "/")
        .replaceAll(".png", "");
    print("this " + imgpath);
    try {
      int quan = int.parse(currentQuantity);
      DatabaseReference ref = database.ref(path);
      if (type == "increament") {
        ref.child("quantity").set("${quan + 1}");
      } else {
        if (quan <= 1) {
          ref.remove();
          String imgpath = img_url
              .replaceAll(
                  "https://firebasestorage.googleapis.com/v0/b/onedir-42e14.appspot.com/o/",
                  "")
              .split("?")[0]
              .replaceAll("%2F", "/");
          print(imgpath);
          await storage.ref(imgpath).delete();
        } else {
          // https://firebasestorage.googleapis.com/v0/b/onedir-42e14.appspot.com/o/StoreImage%2F-MzLaXxLYNxNuuy5lwHo.png?alt=media&token=464455bf-8044-404e-b9a5-35db338a0113
          await ref.child("quantity").set("${quan - 1}");
        }
      }
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  addStoreItem(String quantity, String itemName, String itemDescription,
      File file, BuildContext context) async {
    addStoreController.setIsLoading(true);

    DateTime dt = DateTime.now();

    DatabaseReference ref = database
        .ref()
        .child("Store")
        .child(edirPAgeController.currentEdir.value.eid)
        .push();
    try {
      String? imgUrl =
          await uploadImage("StoreImage/${ref.key.toString()}.png", file);

      Store store = Store(
          imgUrl!,
          itemDescription,
          itemName,
          ref.key.toString(),
          "${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute}",
          quantity);

      await ref.update(store.toFirebaseMap(store));

      DatabaseEvent events = await database
          .ref()
          .child("EdirMembers")
          .child(edirPAgeController.currentEdir.value.eid)
          .once();

      Map<dynamic, dynamic> data =
          events.snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        SendNotification sendNotification = SendNotification(
            title: "Store", body: "$itemName is Added.", topic: value['uid']);

        sendNotification.send();
      });

      MSGSnack errorMSG = MSGSnack(
          color: Colors.green,
          title: "Success!",
          msg: "You have successfully added.");
      errorMSG.show();

      addStoreController.setIsLoading(false);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (c) =>
                  EdirPage(edirId: edirPAgeController.currentEdir.value.eid)),
          (route) => false);
    } catch (e) {
      addStoreController.setIsLoading(false);

      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  addAnnouncement(
      String title, String description, BuildContext context) async {
    addAnnouncementController.setIsLoading(true);

    DateTime dt = DateTime.now();

    DatabaseReference ref = database
        .ref()
        .child("Announcements")
        .child(edirPAgeController.currentEdir.value.eid)
        .push();
    try {
      Announcement announcement = Announcement(
          "${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute}",
          description,
          title,
          ref.key.toString());

      Map<String, Object> map = announcement.toFirebaseMap(announcement);

      await ref.update(map);

      DatabaseEvent events = await database
          .ref()
          .child("EdirMembers")
          .child(edirPAgeController.currentEdir.value.eid)
          .once();

      Map<dynamic, dynamic> data =
          events.snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        SendNotification sendNotification = SendNotification(
            title: "Announcement", body: "About $title", topic: value['uid']);

        sendNotification.send();
      });

      addAnnouncementController.setIsLoading(false);

      MSGSnack errorMSG = MSGSnack(
          color: Colors.green,
          title: "Success!",
          msg: "Announcement Is Successfully Added.");
      errorMSG.show();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (c) =>
                  EdirPage(edirId: edirPAgeController.currentEdir.value.eid)),
          (route) => false);
    } catch (e) {
      addAnnouncementController.setIsLoading(false);

      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  changePaymentRequestState(String state, String ref, PaymentRequest payment,
      {String? transationId}) async {
    try {
      if (state == "Payed") {
        await database.ref(ref).child("state").set(state);
        await database.ref(ref).child("transactionId").set(transationId);
      } else {
        await database.ref(ref).child("state").set(state);
      }

      SendNotification sendNotification = SendNotification(
          title: "${payment.title}",
          body: "your payment is ${state}.",
          topic: payment.receiverId);

      sendNotification.send();
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  Future<void> sendPaymentRequest(String receiverId, String state, String title,
      String description, String eid) async {
    try {
      DatabaseReference ref =
          database.ref().child("PaymentRequest").child(receiverId).push();
      PaymentRequest paymentRequest = PaymentRequest(auth.currentUser!.uid,
          description, receiverId, state, title, ref.key.toString(), eid);
      Map<String, dynamic> map = paymentRequest.toFirbaseMap(paymentRequest);
      await ref.update(map);

      SendNotification sendNotification = SendNotification(
          title: title,
          body: "You have recieved payment request",
          topic: receiverId);

      sendNotification.send();

      MSGSnack errorMSG = MSGSnack(
          color: Colors.green, title: "Success!", msg: "Successfully uploaded");
      errorMSG.show();
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  addChat(String text, String userName, String img_url, String eid) async {
    try {
      DatabaseReference ref =
          database.ref().child("GroupChat").child(eid).push();
      Chat chat = Chat(text, ref.key.toString(), userName, img_url);
      Map<String, Object> chatMap = chat.toFirebaseMap(chat);
      await ref.update(chatMap);

      DatabaseEvent events = await database
          .ref()
          .child("EdirMembers")
          .child(edirPAgeController.currentEdir.value.eid)
          .once();

      Map<dynamic, dynamic> data =
          events.snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        SendNotification sendNotification = SendNotification(
            title: "Group Chat", body: "$userName: $text", topic: value['uid']);

        sendNotification.send();
      });
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
  }

  Future<List<BankAccountOption>> getOptionsUser(String eid) async {
    List<BankAccountOption> options = [];
    try {
      final ds = await database.ref().child("PaymentOptions").child(eid).get();
      if (ds.exists) {
        // var optionsMap = databaseEvent.snapshot.value! as Map;

        for (var option in ds.children) {
          BankAccountOption optionModel =
              BankAccountOption.fromFirebase(option.value as Map);
          options.add(optionModel);
        }
      }
    } catch (e) {
      MSGSnack errorMSG =
          MSGSnack(color: Colors.red, title: "Error!", msg: e.toString());
      errorMSG.show();
    }
    return options;
  }

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
        "uid": auth.currentUser!.uid
      };

      await database
          .ref()
          .child("Users")
          .child(auth.currentUser!.uid)
          .update(map);
      myProfileController.setIsLoading(false);

      MSGSnack msgSnack = MSGSnack(
          title: "Success!",
          msg: "You have successfully updated your profile.",
          color: Colors.green);
      msgSnack.show();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => EdirPage(
                    edirId: edirPAgeController.currentEdir.value.eid,
                  )),
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
        Map<dynamic, dynamic> data = databaseEvent.snapshot.value as Map;
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
          await ref.child("MyEdirLists").child(auth.currentUser!.uid).once();
      if (databaseEvent.snapshot.exists) {
        Map<dynamic, dynamic> edirData =
            Map<dynamic, dynamic>.from(databaseEvent.snapshot.value as Map);
        // List<String> edirIds = [];
        for (String id in edirData.keys) {
          DatabaseEvent edirEvents = await ref.child("Edirs").child(id).once();
          Map<dynamic, dynamic> edirData =
              Map<dynamic, dynamic>.from(edirEvents.snapshot.value as Map);
          Edir edirModel = Edir.fromFirebaseMap(edirData);
          edirList.add(edirModel);
        }
        mainController.edirList.value = edirList;
      }
    } catch (e) {
      MSGSnack msgSnack =
          MSGSnack(title: "!Error this", msg: e.toString(), color: Colors.red);
      msgSnack.show();
    }

    return edirList;
  }

  Future<bool?> getUserInfo() async {
    try {
      DatabaseEvent databaseEvent = await database
          .ref()
          .child("Users")
          .child(auth.currentUser!.uid)
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
    return null;
  }

  joinEdir(String edirId, String position, BuildContext context,
      String edirName) async {
    EdirMember edirMember = EdirMember(mainController.myInfo.value.img_url,
        position, auth.currentUser!.uid, mainController.myInfo.value.userName);

    Map<String, Object> joiningUser = edirMember.tofirebaseMap(edirMember);
    Map<String, Object> myEdirListItem = {"eid": edirId};

    try {
      joinEdirController.setIsLoading(true);

      await database
          .ref()
          .child("EdirMembers")
          .child(edirId)
          .child(auth.currentUser!.uid)
          .update(joiningUser);
      await database
          .ref()
          .child("MyEdirLists")
          .child(auth.currentUser!.uid)
          .child(edirId)
          .update(myEdirListItem);

      if (position != "Admin") {
        SendNotification sendNotification = SendNotification(
            title: "Welcome Messege",
            body: "Welcome to $edirName Edir",
            topic: mainController.myInfo.value.uid);

        sendNotification.send();
      }

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

  updateEdir(
      Map<String, Object> options,
      String eid,
      String edirName,
      String rules,
      String edirAddress,
      String edirBio,
      String durationOfPayment,
      String amountOfMoney,
      BuildContext context) async {
    DatabaseReference ref = database.ref().child("Edirs").child(eid);

    edirInfoController.setIsLoading(true);

    Map<String, Object> newEdir = {
      "eid": eid,
      "edirName": edirName,
      "edirAddress": edirAddress,
      "edirBio": edirBio,
      "durationOfPayment": durationOfPayment,
      "amountOfMoney": amountOfMoney,
      "rules": rules,
      "created_by": auth.currentUser!.uid,
      "created_by_name": mainController.myInfo.value.userName
    };

    try {
      await ref.update(newEdir);

      await database
          .ref()
          .child("PaymentOptions")
          .child(ref.key.toString())
          .update(options);
      edirInfoController.setIsLoading(false);

      MSGSnack msgSnack = MSGSnack(
          title: "Success!",
          msg: "You have successfully updated you edir.",
          color: Colors.green);
      msgSnack.show();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => EdirPage(edirId: eid)),
          (route) => false);
    } catch (e) {
      edirInfoController.setIsLoading(false);
      MSGSnack msgSnack = MSGSnack(
          title: "Error on uploading data!",
          msg: e.toString(),
          color: Colors.red);
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

    String? url =
        await uploadImage("EdirImage/${ref.key.toString()}.png", file);

    Map<String, Object> newEdir = {
      "eid": ref.key.toString(),
      "edirName": edirName,
      "edirAddress": edirAddress,
      "edirBio": edirBio,
      "durationOfPayment": durationOfPayment,
      "amountOfMoney": amountOfMoney,
      "rules": rules,
      "img_url": url!,
      "created_by": auth.currentUser!.uid,
      "created_by_name": mainController.myInfo.value.userName
    };

    try {
      await ref.update(newEdir);

      await database
          .ref()
          .child("PaymentOptions")
          .child(ref.key.toString())
          .update(options);

      await joinEdir(ref.key.toString(), "Admin", context, edirName);
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
        String? imgUrl =
            await uploadImage("Users/${auth.currentUser!.uid}.png", file);

        Map<String, Object> map = {
          "img_url": imgUrl!,
          "email": email,
          "userName": userName,
          "userBio": userBio,
          "userPhone": userPhone,
          "userRsPhone": userRsPhone,
          "familyMembers": familyMembers,
          "noOfFamily": noOfFamily,
          "uid": auth.currentUser!.uid
        };

        await database
            .ref()
            .child("Users")
            .child(auth.currentUser!.uid)
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
