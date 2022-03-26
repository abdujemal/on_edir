import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/announcement_page.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/meeting_page.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/store_page.dart';
import 'package:on_edir/View/Widgets/bottom_bar.dart';
import 'package:on_edir/View/Widgets/edir_drawer.dart';
import 'package:on_edir/constants.dart';

class EdirPage extends StatefulWidget {
  EdirPage({Key key}) : super(key: key);

  @override
  State<EdirPage> createState() => _EdirPageState();
}

class _EdirPageState extends State<EdirPage> {
  var _key = GlobalKey<ScaffoldState>();

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.announcement,), label: "Announcement"),
    BottomNavigationBarItem(icon: Icon(Icons.store,), label: "Store"),
    BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Meeting")  ];
  
  List<Widget> pages = [
    AnnouncementPage(),
    StorePage(),
    MeetingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        drawer: const EdirDrawer(),
        bottomNavigationBar: BottomBar(items: items),
        appBar: AppBar(
          title: const Text("Edir Name"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Image.asset(
                "assets/dots.png",
                color: Colors.white,
                width: 25,
              ),
            )
          ],
        ),
        body: Obx(() => pages[edirPAgeController.selectedIndex.value]),
      ),
    );
  }
}
