import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
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

  GlobalKey<FormState> _optionKey = GlobalKey();

  TextEditingController accountTc = TextEditingController();

  TextEditingController bankTc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    edirAddressTc.dispose();
    edirRulesTc.dispose();
    edirNameTc.dispose();
    accountTc.dispose();
    bankTc.dispose();
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Column(
                  children: [
                    Obx(
                      () =>
                    Row(
                      children: [
                        const Text(
                          "Bank Account Options",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ActionBtn(
                            text: "Add Option",
                            action: () {
                              if (_optionKey.currentState.validate()) {
                                edirInfoController.addList(BankAccountOption(
                                    bankTc.text, accountTc.text));
                                bankTc.text = "";
                                accountTc.text = "";
                              }
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        edirInfoController.options.value.isEmpty
                            ? const SizedBox()
                            : ActionBtn(
                                text: "Clear",
                                action: () {
                                  edirInfoController.options.clear();
                                },
                              )
                      ],
                    ),
                    ),
                    Form(
                      key: _optionKey,
                      child: Column(
                        children: [
                          CommonInput(
                              controller: bankTc,
                              hint: "Bank or Provider",
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonInput(
                              controller: accountTc,
                              hint: "Account for transfer money",
                              keyboardType: TextInputType.text),
                        ],
                      ),
                    ),
                    Obx(
                      () => Column(
                          children: edirInfoController.options.value.isNotEmpty
                              ? edirInfoController.options.value
                                  .map(
                                    (v) => ListTile(
                                      trailing: const Icon(Icons.payment),
                                      title: Text(v.bank),
                                      subtitle: Text(v.account),
                                    ),
                                  )
                                  .toList()
                              : []),
                    )
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
