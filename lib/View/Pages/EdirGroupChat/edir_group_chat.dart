import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/chat.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/chat_item.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/constants.dart';

class EdirGroupChat extends StatefulWidget {
  const EdirGroupChat({Key key}) : super(key: key);

  @override
  State<EdirGroupChat> createState() => _EdirGroupChatState();
}

class _EdirGroupChatState extends State<EdirGroupChat> {
  TextEditingController chatTc = TextEditingController();

  DatabaseReference chatRef =
      FirebaseDatabase.instance.ref().child("GroupChat");

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("EdirName Group Chat"),
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
                          List<Chat> chatList = [];
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic> data =
                                Map<dynamic, dynamic>.from(
                                    (snapshot.data as DatabaseEvent)
                                        .snapshot
                                        .value);
                            for (Map<dynamic, dynamic> chatData
                                in data.values) {
                              Map<dynamic, dynamic> data =
                                  Map<dynamic, dynamic>.from(chatData);
                              Chat chatModel = Chat.fromFirebaseMap(data);
                              chatList.add(chatModel);
                            }
                          }
                          return chatList.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: chatList.length,
                                  itemBuilder: (context, index) => ChatItem(
                                      userName: chatList[index].userName,
                                      text: chatList[index].text,
                                      img_url: chatList[index].img_url));
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
                                  hintText: "Write something")),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {},
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
