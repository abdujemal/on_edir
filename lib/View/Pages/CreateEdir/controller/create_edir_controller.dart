import 'dart:io';

import 'package:get/get.dart';

class CreateEdirController extends GetxController {
  RxBool isLoading = false.obs;
  RxString pickedfilePath = "".obs;
  
  var options = [].obs;

  setIsLoading(bool val) {
    isLoading.value = val;
  }

  setImage(String file) {
    pickedfilePath.value = file;
  }
}
