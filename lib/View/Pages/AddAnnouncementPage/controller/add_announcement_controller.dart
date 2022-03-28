import 'package:get/get.dart';

class AddAnnouncementController extends GetxController {
  RxBool isLoading = false.obs;

  setIsLoading(bool val) {
    isLoading.value = val;
  }
}
