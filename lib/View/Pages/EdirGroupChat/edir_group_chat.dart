import 'package:flutter/material.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/constants.dart';

class EdirGroupChat extends StatefulWidget {
  const EdirGroupChat({Key key}) : super(key: key);

  @override
  State<EdirGroupChat> createState() => _EdirGroupChatState();
}

class _EdirGroupChatState extends State<EdirGroupChat> {
  TextEditingController chatTc = TextEditingController();
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
             Container(),
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
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Write something")),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.send),color: Colors.white,),
                      SizedBox(width: 10,)
                    ],
                  ),
             )
          ],
        ),
      ),
    );
  }
}
