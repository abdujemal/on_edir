import 'package:get/get.dart';

class StoreDetailController extends GetxController {
  RxBool isLoading = false.obs;
  setIsLoading(bool val) {
    isLoading.value = val;
  }
}
