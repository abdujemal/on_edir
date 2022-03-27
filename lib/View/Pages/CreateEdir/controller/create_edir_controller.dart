import 'dart:io';

import 'package:get/get.dart';

class CreateEdirController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<File> pickedfile = File("").obs;

  setIsLoading(bool val) {
    isLoading.value = val;
  }

  setImage(File file) {
    pickedfile.value = file;
  }
}
