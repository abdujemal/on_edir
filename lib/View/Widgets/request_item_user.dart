import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/constants.dart';

class RequestItemUser extends StatelessWidget {
  PaymentRequest paymentRequest;
  RequestItemUser({Key key, @required this.paymentRequest}) : super(key: key);

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  UserService userService = Get.put(UserService());

  Widget actionBtn() {
    if (paymentRequest.state == "Payed") {
      return null;
    } else if (paymentRequest.state == "Pending") {
      return null;
    } else {
      return ElevatedButton(
          onPressed: () {
            userService.changePaymentRequestState(
                "Pending", "PaymentRequest/${paymentRequest.receiverId}/${paymentRequest.pid}");
          },
          child: const Text("I'v Payed"));
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
              ),
            ],
          ),
          ListTile(
              title: Text(paymentRequest.title),
              subtitle: Text(paymentRequest.description),
              leading: const Icon(Icons.payment),
              trailing: actionBtn()),
        ]),
      ),
    );
  }
}
