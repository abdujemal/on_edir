import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/View/Pages/CreateEdir/controller/create_edir_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
import 'package:on_edir/constants.dart';

class CreateEdirPage extends StatefulWidget {
  const CreateEdirPage({Key key}) : super(key: key);

  @override
  State<CreateEdirPage> createState() => _CreateEdirPageState();
}

class _CreateEdirPageState extends State<CreateEdirPage> {
  TextEditingController edirNameTc = TextEditingController();
  TextEditingController edirRulesTc = TextEditingController();
  TextEditingController edirAddressTc = TextEditingController();

  UserService userService = Get.put(UserService());

  CreateEdirController createEdirController = Get.put(CreateEdirController());

  var edirAmountOfMoneyTc = TextEditingController();

  var edirBioTc = TextEditingController();

  var edirDurationOfPaymentTc = TextEditingController();

  GlobalKey<FormState> _optionKey = GlobalKey();

  GlobalKey<FormState> _createEdirKey = GlobalKey();

  var bankTc = TextEditingController();

  var accountTc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    edirAddressTc.dispose();
    edirRulesTc.dispose();
    edirNameTc.dispose();
    edirAmountOfMoneyTc.dispose();
    edirBioTc.dispose();
    edirDurationOfPaymentTc.dispose();
    bankTc.dispose();
    accountTc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Create Edir"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _createEdirKey,
            child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Obx(() => createEdirController.pickedfilePath.value != ""
                          ? Image.file(
                              File(
                                createEdirController.pickedfilePath.value,
                              ),
                              width: 100,
                              height: 100,
                            )
                          : const Icon(Icons.image, size: 150)),
                      Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton(
                          onPressed: () async {
                            XFile imagexFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (imagexFile != null) {
                              createEdirController.setImage(imagexFile.path);
                            } else {
                              MSGSnack msgSnack = MSGSnack(
                                  title: "Alert!",
                                  msg: "Image is not picked",
                                  color: Colors.red);
                              msgSnack.show();
                            }
                          },
                          icon: const Icon(
                            Icons.add_a_photo_sharp,
                            color: Colors.black,
                          ),
                        ),
                      )
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
                    height: 20,
                  ),
                  CommonInput(
                      controller: edirBioTc,
                      hint: "Edir Bio",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonInput(
                      controller: edirAddressTc,
                      hint: "Edir Address",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonInput(
                      controller: edirAmountOfMoneyTc,
                      hint: "Amount Of Money",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonInput(
                      controller: edirDurationOfPaymentTc,
                      hint: "Durations Of Payment",
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonInput(
                    controller: edirRulesTc,
                    hint: "Edir Rules and Regulations",
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    child: Column(
                      children: [
                        Obx(
                          () => Row(
                            children: [
                              const Text(
                                "Bank Account Options",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              const SizedBox(
                                width: 10,
                              ),
                              createEdirController.options.value.isEmpty
                                  ? const SizedBox()
                                  : ActionBtn(
                                      text: "Clear",
                                      action: () {
                                        createEdirController.options.clear();
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
                        SizedBox(
                          height: 5,
                        ),
                        ActionBtn(
                            text: "Add Option",
                            action: () {
                              if (_optionKey.currentState.validate()) {
                                createEdirController.options.add(
                                    BankAccountOption(
                                        bankTc.text, accountTc.text));
                                bankTc.text = "";
                                accountTc.text = "";
                              }
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Column(
                              children: createEdirController
                                      .options.value.isNotEmpty
                                  ? createEdirController.options.value
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
                  Obx(
                    () => createEdirController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CommonBtn(
                            text: "Create Edir",
                            action: () {
                              if (!_createEdirKey.currentState.validate()) {
                              } else if (createEdirController
                                      .pickedfilePath.value ==
                                  "") {
                                MSGSnack msgSnack = MSGSnack(
                                    title: "Alert!",
                                    msg: "Please Choose your Edir Image.",
                                    color: Colors.red);
                                msgSnack.show();
                              } else if (createEdirController.options.isEmpty) {
                                MSGSnack msgSnack = MSGSnack(
                                    title: "Alert!",
                                    msg: "Please add your payment options.",
                                    color: Colors.red);
                                msgSnack.show();
                              } else {
                                int i = 0;
                                Map<String, Object> optionMap = {};
                                for (BankAccountOption option
                                    in createEdirController.options) {
                                  i++;
                                  optionMap.addIf(true, "$i", {
                                    "bank": option.bank,
                                    "account": option.account
                                  });
                                }
                                userService.createEdir(
                                    optionMap,
                                    edirNameTc.text,
                                    edirRulesTc.text,
                                    edirAddressTc.text,
                                    edirBioTc.text,
                                    edirDurationOfPaymentTc.text,
                                    edirAmountOfMoneyTc.text,
                                    File(createEdirController
                                        .pickedfilePath.value),
                                    context);
                              }
                            }),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
