import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommonInput extends StatelessWidget {
  TextInputType keyboardType;
  String hint;
  TextEditingController controller;
  IconData prefixIcon;
  int maxLines;

  CommonInput(
      {Key key,
      @required this.controller,
      @required this.hint,
      this.prefixIcon = null,
      this.maxLines = 1,
      @required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        // ignore: missing_return
        validator: (v) {
          if (v.isEmpty) {
            return "This Field is required.";
          }
        },
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          label: Text(
            hint,
            style: const TextStyle(fontSize: 20),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 32, 118, 189))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 73, 137, 189))),
        ),
      ),
    );
  }
}
