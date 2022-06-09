import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/payment_request.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class RequestItemUser extends StatelessWidget {
  PaymentRequest paymentRequest;

  var transactionIdTc = TextEditingController();
  RequestItemUser({Key key, @required this.paymentRequest}) : super(key: key);

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  UserService userService = Get.put(UserService());

  MainController mainController = Get.put(MainController());

  Widget actionBtn() {
    if (paymentRequest.state == "Payed") {
      return null;
    } else if (paymentRequest.state == "Pending") {
      return null;
    } else {
      return ElevatedButton(
          onPressed: () {
            Get.bottomSheet(Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(children: [
                CommonInput(
                    controller: transactionIdTc,
                    hint: "Transaction Id".tr,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CommonBtn(
                    text: "Save".tr,
                    action: () {
                      userService.changePaymentRequestState("Payed",
                          "PaymentRequest/${mainController.myInfo.value.uid}/${paymentRequest.pid}",paymentRequest);
                    })
              ]),
            ));
          },
          child: Text("I'v Payed".tr));
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
              subtitle: paymentRequest.transactionId != null ?
               Text("Amount Of Money: ".tr +
                  paymentRequest.description +
                  ", TransactionId: ".tr+ paymentRequest.transactionId):
                Text("Amount Of Money: ".tr +
                  paymentRequest.description),
              leading: const Icon(Icons.payment),
              trailing: actionBtn()),
        ]),
      ),
    );
  }
}
