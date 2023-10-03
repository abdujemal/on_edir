import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/store.dart';
import 'package:on_edir/Model/store_item_request.dart';
import 'package:on_edir/View/Widgets/common_btn.dart';

class StoreRequestItemAdmin extends StatefulWidget {
  StoreItemRequest storeItemRequest;
  UserService userService;
  StoreRequestItemAdmin(
      {Key? key, required this.userService, required this.storeItemRequest})
      : super(key: key);

  @override
  State<StoreRequestItemAdmin> createState() => _StoreRequestItemAdminState();
}

class _StoreRequestItemAdminState extends State<StoreRequestItemAdmin> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.network(
                  widget.storeItemRequest.p_img,
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
                        widget.storeItemRequest.p_name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: Text(
                              "Reason : ".tr + widget.storeItemRequest.reason)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: Text("Return Date : ".tr +
                              widget.storeItemRequest.dateOfReturn)),
                    ],
                  ),
                )
              ]),
              getButtons(widget.storeItemRequest.state),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.storeItemRequest.date,
                    style: const TextStyle(fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: getColor(widget.storeItemRequest.state),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(8))),
              child: Text(widget.storeItemRequest.state),
            )),
      ],
    );
  }

  getColor(String state) {
    if (state == "Pending") {
      return Colors.grey;
    } else if (state == "Allowed") {
      return Colors.orange;
    } else if (state == "Denied") {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  getButtons(String state) {
    if (state == "Pending") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RawMaterialButton(
            onPressed: () {
              widget.userService
                  .setStoreRequiestState(widget.storeItemRequest, "Allowed");
            },
            fillColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Text("Allow".tr),
          ),
          const SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {
              widget.userService
                  .setStoreRequiestState(widget.storeItemRequest, "Denied");
            },
            fillColor: Colors.red,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Text("Deny".tr),
          ),
        ],
      );
    } else if (state == "Allowed") {
      return RawMaterialButton(
        onPressed: () {
          widget.userService
                  .setStoreRequiestState(widget.storeItemRequest, "Returned");
        },
        fillColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text("Returned".tr),
      );
    } else if (state == "Denied") {
      return RawMaterialButton(
          onPressed: () {
            widget.userService
                  .setStoreRequiestState(widget.storeItemRequest, "Allowed");
          },
          fillColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text("Allow Again".tr));
    } else {
      return const SizedBox();
    }
  }
}
