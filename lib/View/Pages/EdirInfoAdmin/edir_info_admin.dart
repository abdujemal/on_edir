import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/bankaccount_options.dart';
import 'package:on_edir/View/Pages/EdirInfoAdmin/controller/edir_info_controller.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Widgets/action_btn.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/msg_snack.dart';
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

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  GlobalKey<FormState> _optionKey = GlobalKey();

  GlobalKey<FormState> _adminFromKey = GlobalKey();

  TextEditingController accountTc = TextEditingController();

  TextEditingController bankTc = TextEditingController();

  UserService userService = Get.put(UserService());

  @override
  void dispose() {
    // TODO: implement dispose
    edirAddressTc.dispose();
    edirRulesTc.dispose();
    edirNameTc.dispose();
    accountTc.dispose();
    bankTc.dispose();
    edirBioTc.dispose();
    amountOfMoneyTc.dispose();
    durationOfPaymentsTc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    edirAddressTc.text = edirPAgeController.currentEdir.value.edirAddress;
    edirRulesTc.text = edirPAgeController.currentEdir.value.rules;
    edirNameTc.text = edirPAgeController.currentEdir.value.edirName;
    edirBioTc.text = edirPAgeController.currentEdir.value.edirBio;
    amountOfMoneyTc.text = edirPAgeController.currentEdir.value.amountOfMoney;
    durationOfPaymentsTc.text =
        edirPAgeController.currentEdir.value.durationOfPayment;

    getAllOptions();
  }

  getAllOptions() async {
    edirInfoController.options.value = await userService
        .getOptionsUser(edirPAgeController.currentEdir.value.eid);
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
          child: Form(
            key: _adminFromKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          edirPAgeController.currentEdir.value.img_url),
                      radius: 55,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_a_photo_sharp,
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
                  controller: durationOfPaymentsTc,
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
                        () => Row(
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
                                    edirInfoController.addList(
                                        BankAccountOption(
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
                            children:
                                edirInfoController.options.value.isNotEmpty
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
                Obx(() =>
                edirInfoController.isLoading.value?
                const CircularProgressIndicator():
                CommonBtn(
                    text: "Save Changes",
                    action: () {
                      if (!_adminFromKey.currentState.validate()) {
                      } else if (edirInfoController.options.isEmpty) {
                        MSGSnack msgSnack = MSGSnack(
                            title: "Alert!",
                            msg: "Please add options.",
                            color: Colors.green);
                        msgSnack.show();
                      } else {
                        int i = 0;
                        Map<String, Object> optionMap = {};
                        for (BankAccountOption option
                            in edirInfoController.options) {
                          i++;
                          optionMap.addIf(true, "$i",
                              {"bank": option.bank, "account": option.account});
                        }
                        userService.updateEdir(
                            optionMap,
                            edirPAgeController.currentEdir.value.eid,
                            edirNameTc.text,
                            edirRulesTc.text,
                            edirAddressTc.text,
                            edirBioTc.text,
                            durationOfPaymentsTc.text,
                            amountOfMoneyTc.text,
                            context);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
