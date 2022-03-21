import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_edir/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        appBar: AppBar(title: Text("sdfjklh")),
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Icon(Icons.add, size: 20,),
                  SizedBox(height: 10,),
                  Text("Create Edir")
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}