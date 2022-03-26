import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_edir/View/Widgets/edir_member_fr_payment.dart';
import 'package:on_edir/constants.dart';

class PaymentAdmin extends StatefulWidget {
  const PaymentAdmin({Key key}) : super(key: key);

  @override
  State<PaymentAdmin> createState() => _PaymentAdminState();
}

class _PaymentAdminState extends State<PaymentAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            DropdownButton(
              
              icon: const Icon(FontAwesomeIcons.ellipsisH),
              items: [
                    DropdownMenuItem(child: Text("Send Request To All"))
                  ], onChanged: (v) {})          
          ],
          backgroundColor: Colors.transparent,
          title: const Text("EdirName Members"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: ((context, index) => const EdirMemberFrPayment())),
      ),
    );
  }
}
