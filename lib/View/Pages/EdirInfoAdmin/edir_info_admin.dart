import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/payment_options_dialog.dart';
import 'package:on_edir/constants.dart';

class EdirInfoAdmin extends StatefulWidget {
  const EdirInfoAdmin({Key key}) : super(key: key);

  @override
  State<EdirInfoAdmin> createState() => _EdirInfoAdminState();
}

class _EdirInfoAdminState extends State<EdirInfoAdmin> {
  TextEditingController edirNameTc = TextEditingController();
  TextEditingController edirRulesTc = TextEditingController();
  TextEditingController edirAddressTc = TextEditingController();
  TextEditingController edirBioTc = TextEditingController();
  TextEditingController durationOfPaymentsTc = TextEditingController();
  TextEditingController amountOfMoneyTc = TextEditingController();
  EdirInfoController edirInfoController = Get.put(EdirInfoController());

  @override
  void dispose() {
    // TODO: implement dispose
    edirAddressTc.dispose();
    edirRulesTc.dispose();
    edirNameTc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("Edir Info"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  const Icon(Icons.image, size: 150),
                  Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_a_photo_sharp,
                            color: Colors.black,
                            size: 50,
                          )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CommonInput(
                  controller: edirNameTc,
                  hint: "Edir Name",
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              CommonInput(
                  controller: edirBioTc,
                  hint: "Edir Bio",
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              CommonInput(
                  controller: edirAddressTc,
                  hint: "Edir Address",
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              CommonInput(
                controller: edirNameTc,
                hint: "Edir Rules And Regulations",
                keyboardType: TextInputType.text,
                maxLines: 6,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonInput(
                controller: amountOfMoneyTc,
                hint: "Amount of money",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              CommonInput(
                controller: edirNameTc,
                hint: "Duration of payment",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Bank Account Options",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(const PaymentOptionsDialog());
                          },
                          child: Ink(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Add Options",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 201, 201, 201)),
                            ),
                          ),
                        )
                      ],
                    ),
                    ...edirInfoController.options.value.map((v) => ListTile(
                          trailing: const Icon(Icons.payment),
                          title: Text(v.bank),
                          subtitle: Text(v.account),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonBtn(text: "Save Changes", action: () {}),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
