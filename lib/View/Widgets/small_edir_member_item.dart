import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/EdirPage/controller/edir_page_controller.dart';
import 'package:on_edir/View/Pages/MainPage/controller/main_controller.dart';
import 'package:on_edir/constants.dart';

class SmallEdirMemberItem extends StatelessWidget {
  String imgUrl, title, subtitle, id;
  void Function() onTap;
  SmallEdirMemberItem(
      {Key key,
      @required this.imgUrl,
      @required this.title,
      @required this.subtitle,
      @required this.id,
      @required this.onTap})
      : super(key: key);

  EdirPAgeController edirPAgeController = Get.put(EdirPAgeController());

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: onTap,
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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                  Obx(()=>
                  edirPAgeController.currentEdir.value.eid == id
                      ? Positioned(
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
                      : const SizedBox(),)
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
