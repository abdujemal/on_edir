import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class PaymentUser extends StatefulWidget {
  const PaymentUser({ Key key }) : super(key: key);

  @override
  State<PaymentUser> createState() => _PaymentUserState();
}

class _PaymentUserState extends State<PaymentUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent,title: Text("Payment Page"),centerTitle: true,),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index)=>Container() ),
      ),
    );
  }
}