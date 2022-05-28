import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/View/Pages/StoreDetail/controller/store_detail_controller.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';
import 'package:on_edir/View/Widgets/common_input.dart';
import 'package:on_edir/View/Widgets/edir_info_item.dart';
import 'package:on_edir/View/Widgets/stroe_item.dart';
import 'package:on_edir/constants.dart';

import '../../../Model/store.dart';

class StoreDetail extends StatefulWidget {
  Store store;
  StoreDetail({Key key, @required this.store}) : super(key: key);

  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  var reasonTc = TextEditingController();

  var dateOfReturnTC = TextEditingController();

  UserService userService = Get.put(UserService());

  StoreDetailController storeDetailController =
      Get.put(StoreDetailController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Store Detail".tr),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.store.img_url),
              radius: 70,
            ),
            const SizedBox(
              height: 10,
            ),
            EdirInfoItem(title: "Store Item Name".tr, value: widget.store.itemName),
            Column(children: [
              Text("Store Description".tr,style: TextStyle(fontSize: 20),),
              const SizedBox(height: 5,),
              Text(widget.store.itemDescription)
            ],),
            CommonInput(
                controller: reasonTc,
                hint: "Reason of Renting".tr,
                keyboardType: TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            CommonInput(
                controller: dateOfReturnTC,
                hint: "Date Of Return".tr,
                keyboardType: TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            Obx(() => storeDetailController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CommonBtn(
                    text: "Send".tr,
                    action: () {
                      userService.sendStoreRentRequest(reasonTc.text, dateOfReturnTC.text, context, widget.store.img_url, widget.store.sid);
                    }))
          ]),
        ),
      ),
    );
  }
}
