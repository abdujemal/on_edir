import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class JoinEdirPage extends StatefulWidget {
  const JoinEdirPage({Key key}) : super(key: key);

  @override
  State<JoinEdirPage> createState() => _JoinEdirPageState();
}

class _JoinEdirPageState extends State<JoinEdirPage> {
  TextEditingController _edirCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Join Edir"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            CommonInput(
                controller: _edirCodeController,
                hint: "Edir Code",
                keyboardType: TextInputType.text),
            const SizedBox(
              height: 50,
            ),
            CommonBtn(
              action: () {
                Get.to(() => EdirPage());
              },
              text: "Join",
            )
          ],
        ),
      ),
    );
  }
}
