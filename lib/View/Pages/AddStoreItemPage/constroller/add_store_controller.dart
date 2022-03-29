import 'package:get/get.dart';

class AddStoreController extends GetxController {
  RxBool isLoading = false.obs;

  RxString filePath = "".obs;

  setIsLoading(bool val) {
    isLoading.value = val;
  }

  setFilePath(String path) {
    filePath.value = path;
  }
}
