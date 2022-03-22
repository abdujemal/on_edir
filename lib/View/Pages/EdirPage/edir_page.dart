import 'package:flutter/material.dart';
import 'package:on_edir/View/Widgets/edir_drawer.dart';
import 'package:on_edir/constants.dart';

class EdirPage extends StatefulWidget {
  EdirPage({Key key}) : super(key: key);

  @override
  State<EdirPage> createState() => _EdirPageState();
}

class _EdirPageState extends State<EdirPage> {
  var _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        drawer: const EdirDrawer(),
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
      ),
    );
  }
}
