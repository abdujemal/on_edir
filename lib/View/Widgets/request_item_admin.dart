import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/constants.dart';

class RequestItemAdmin extends StatelessWidget {
  PaymentRequest paymentRequest;
  RequestItemAdmin({Key? key, required this.paymentRequest}) : super(key: key);

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  UserService userService = Get.put(UserService());

  Widget? actionBtn() {
    if (paymentRequest.state == "Payed") {
      return null;
    } else if (paymentRequest.state == "Pending") {
      return SizedBox(
        width: 110,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  userService.changePaymentRequestState("Payed",
                      "PaymentRequest/${paymentRequest.receiverId}/${paymentRequest.pid}",paymentRequest);
                },
                icon: const Icon(Icons.check,color: Colors.green,)),
            const SizedBox(width: 10,),
            IconButton(
                onPressed: () {
                  userService.changePaymentRequestState("NotPayed",
                      "PaymentRequest/${paymentRequest.receiverId}/${paymentRequest.pid}",paymentRequest);
                },
                icon: const Icon(FontAwesomeIcons.times ,color: Colors.red,)),
          ],
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          border: Border(bottom: BorderSide(color: secondColor))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: paymentRequest.state != "Payed"
                        ? Colors.brown
                        : Colors.green,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(paymentRequest.state),
                ),
              )
            ],
          ),
          ListTile(
              title: Text(paymentRequest.title),
              subtitle: paymentRequest.transactionId != null ?
               Text("Amount Of Money: ".tr +
                  paymentRequest.description +
                  ", TransactionId: ".tr+ paymentRequest.transactionId!):
                Text("Amount Of Money: ".tr +
                  paymentRequest.description),
              leading: const Icon(Icons.payment),
              trailing: actionBtn()),
        ]),
      ),
    );
  }
}
