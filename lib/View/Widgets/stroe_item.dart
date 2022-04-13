import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/store.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/constants.dart';

class StoreItem extends StatelessWidget {
  Store store;
  StoreItem({Key key, @required this.store}) : super(key: key);

  UserService userService = Get.put(UserService());
  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());
  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          border: Border(bottom: BorderSide(color: secondColor))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.network(
                store.img_url,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(
                      store.itemName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 200, child: Text(store.itemDescription)),
                  ],
                ),
              )
            ]),
            edirPAgeController.currentEdir.value.created_by != mainController.myInfo.value.uid ?
            const SizedBox():
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          userService.editStore("increament",
                              "Store/${store.sid}", store.quantity);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    Text(store.quantity),
                    IconButton(
                        onPressed: () {
                          userService.editStore("decreament",
                              "Store/${store.sid}", store.quantity);
                        },
                        icon: const Text(
                          "-",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  store.dateTime,
                  style: const TextStyle(fontSize: 13),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
