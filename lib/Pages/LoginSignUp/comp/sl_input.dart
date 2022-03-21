import 'package:flutter/material.dart';
import 'package:on_edir/constants.dart';

class SLInput extends StatelessWidget {
  String title, hint;
  TextInputType keyboardType;
  TextEditingController controller;
  SLInput(
      {Key key,
      @required this.title,
      @required this.hint,
      @required this.keyboardType,
      @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return "This Field is required.";
              }
            },
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                hoverColor: whiteColor,
                hintText: hint,
                contentPadding: const EdgeInsets.all(5)),
          )
        ],
      ),
    );
  }
}
