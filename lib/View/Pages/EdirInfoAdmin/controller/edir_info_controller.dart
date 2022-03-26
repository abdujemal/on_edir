import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:on_edir/Model/bankaccount_options.dart';

class EdirInfoController extends GetxController {
  var options = [].obs;

  void addList(BankAccountOption val) {
    options.add(val);
  }

  void clearData() {
    options.clear();
  }

  bool isEmpty() {
    return options.value.length == 0;
  }
}
