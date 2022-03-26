import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/PaymentUser/payment_user.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/constants.dart';

class EdirMemberFrPayment extends StatelessWidget {
  const EdirMemberFrPayment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const PaymentUser());
      },
      child: Ink(
        decoration: BoxDecoration(
            color: mainColor,
            border: Border(bottom: BorderSide(color: secondColor))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Member name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Member Position",
                    style: TextStyle(
                        color: Colors.grey, overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
              const Spacer(),
              ActionBtn(text: "Send Request", action: () {})
            ],
          ),
        ),
      ),
    );
  }
}
