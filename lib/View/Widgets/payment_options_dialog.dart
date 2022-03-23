import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/constants.dart';

class PaymentOptionsDialog extends StatefulWidget {
  const PaymentOptionsDialog({Key key}) : super(key: key);

  @override
  State<PaymentOptionsDialog> createState() => _PaymentOptionsDialogState();
}

class _PaymentOptionsDialogState extends State<PaymentOptionsDialog> {
  EdirInfoController edirInfoController = Get.put(EdirInfoController());
  TextEditingController bank = TextEditingController();
  TextEditingController account = TextEditingController();

  GlobalKey<FormState> _optionKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          gradient: bgGradient, borderRadius: BorderRadius.circular(20)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  "Add Payment Options",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _optionKey,
                child: Column(
                  children: [
                    CommonInput(
                        controller: bank,
                        hint: "Bank or Provider",
                        keyboardType: TextInputType.text),
                    SizedBox(
                      height: 5,
                    ),
                    CommonInput(
                        controller: account,
                        hint: "Account for transfer money",
                        keyboardType: TextInputType.text),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CommonBtn(
                  text: "Add",
                  action: () {
                    if(_optionKey.currentState.validate()){
                      edirInfoController.options.value
                        .add(BankAccountOption(bank.text, account.text));
                    }
                    
                  })
            ],
          ),
        ),
      ),
    );
  }
}
