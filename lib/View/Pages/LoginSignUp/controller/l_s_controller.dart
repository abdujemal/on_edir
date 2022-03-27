import 'dart:io';

import 'package:get/get.dart';

class LSController extends GetxController {
  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;
  Rx<File> pickedFile = File("").obs;

  setIsLogin(bool val) {
    isLogin.value = val;
  }

  setIsLoading(bool val) {
    isLoading.value = val;
  }

  setPickedImage(File file) {
    pickedFile.value = file;
  }
}
