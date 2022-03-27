import 'dart:io';

import 'package:get/get.dart';

class LSController extends GetxController {
  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;

  Rx<String> pickedFilePath = "".obs;

  setIsLogin(bool val) {
    isLogin.value = val;
  }

  setIsLoading(bool val) {
    isLoading.value = val;
  }

  setPickedImage(String filePath) {
    pickedFilePath.value = filePath;
  }

  bool isEmpty() {
    return pickedFilePath.value == "";
  }
}
