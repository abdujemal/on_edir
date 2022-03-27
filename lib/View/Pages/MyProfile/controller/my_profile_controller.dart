import 'package:get/get.dart';

class MyProfileController extends GetxController {
  RxBool isLoading = false.obs;

  void setIsLoading(bool val) {
    isLoading.value = val;
  }
}
