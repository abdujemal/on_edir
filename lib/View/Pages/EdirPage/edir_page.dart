import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/announcement_page.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/meeting_page.dart';
import 'package:on_edir/View/Pages/EdirPage/tabs/store_page.dart';
import 'package:on_edir/View/Widgets/bottom_bar.dart';
import 'package:on_edir/View/Widgets/edir_drawer.dart';
import 'package:on_edir/constants.dart';

class EdirPage extends StatefulWidget {
  String edirId;
  EdirPage({Key key, @required this.edirId}) : super(key: key);

  @override
  State<EdirPage> createState() => _EdirPageState();
}

class _EdirPageState extends State<EdirPage> {
  var _key = GlobalKey<ScaffoldState>();

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.announcement,
        ),
        label: "Announcement"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.store,
        ),
        label: "Store"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.video_call), label: "Meeting")
  ];

  List<Widget> pages = [
    const AnnouncementPage(),
    const StorePage(),
    const MeetingPage()
  ];

  UserService userService = Get.put(UserService());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.edirId);
    userService.getEdir(widget.edirId);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserService()).getUserInfo();
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        drawer: const EdirDrawer(),
        bottomNavigationBar: BottomBar(items: items),
        appBar: AppBar(
          title: Text(edirPAgeController.currentEdir.value.edirName),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
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
