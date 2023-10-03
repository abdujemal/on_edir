import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/Controller/user_service.dart';
import 'package:on_edir/Model/store_item_request.dart';

class StoreRequestItemUser extends StatefulWidget {
  StoreItemRequest storeItemRequest;
  UserService userService;
  StoreRequestItemUser({ Key? key, required this.storeItemRequest, required this.userService }) : super(key: key);

  @override
  State<StoreRequestItemUser> createState() => _StoreRequestItemUserState();
}

class _StoreRequestItemUserState extends State<StoreRequestItemUser> {
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
}