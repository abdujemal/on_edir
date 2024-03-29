import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/chat.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/chat_item.dart';
import 'package:on_edir/constants.dart';

class EdirGroupChat extends StatefulWidget {
  const EdirGroupChat({Key? key}) : super(key: key);

  @override
  State<EdirGroupChat> createState() => _EdirGroupChatState();
}

class _EdirGroupChatState extends State<EdirGroupChat> {
  TextEditingController chatTc = TextEditingController();

  DatabaseReference chatRef =
      FirebaseDatabase.instance.ref().child("GroupChat");

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  MainController mainController = Get.put(MainController());

  UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Obx(() => edirPAgeController.currentEdir.value == null
              ? const SizedBox()
              : Text(edirPAgeController.currentEdir.value.edirName +
                  "Group Chat".tr)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: StreamBuilder(
                        stream: chatRef
                            .child(edirPAgeController.currentEdir.value.eid)
                            .onValue,
                        builder: (context, snapshot) {
                          List<Chat>? chatList = null;
                          if (snapshot.hasData) {
                            chatList = [];
                            if ((snapshot.data as DatabaseEvent)
                                    .snapshot
                                    .value !=
                                null) {
                              Map<dynamic, dynamic> data =
                                  (snapshot.data as DatabaseEvent)
                                      .snapshot
                                      .value as Map;
                              for (Map<dynamic, dynamic> chatData
                                  in data.values) {
                                Map<dynamic, dynamic> data =
                                    Map<dynamic, dynamic>.from(chatData);
                                Chat chatModel = Chat.fromFirebaseMap(data);
                                if (chatModel.cid != null) {
                                  chatList.add(chatModel);
                                }
                              }
                              chatList.sort(((a, b) => b.cid
                                  .toLowerCase()
                                  .compareTo(a.cid.toLowerCase())));
                            }
                          }
                          return chatList == null
                              ? const Center(child: CircularProgressIndicator())
                              : chatList.isEmpty
                                  ? Center(
                                      child: Text("No Chat".tr),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50.0),
                                      child: ListView.builder(
                                          reverse: true,
                                          itemCount: chatList.length,
                                          itemBuilder: (context, index) =>
                                              ChatItem(
                                                  userName:
                                                      chatList![index].userName,
                                                  text: chatList[index].text,
                                                  img_url:
                                                      chatList[index].img_url)),
                                    );
                        }),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                              controller: chatTc,
                              style: TextStyle(color: mainColor),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration.collapsed(
                                  hintStyle: TextStyle(color: mainColor),
                                  hintText: "Write something".tr)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      if (chatTc.text.isNotEmpty) {
                        userService.addChat(
                            chatTc.text,
                            mainController.myInfo.value.userName,
                            mainController.myInfo.value.img_url,
                            edirPAgeController.currentEdir.value.eid);

                        chatTc.text = "";
                      }
                    },
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
