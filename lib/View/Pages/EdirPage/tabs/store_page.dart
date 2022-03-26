import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({ Key key }) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Store Page")),
    );
  }
}