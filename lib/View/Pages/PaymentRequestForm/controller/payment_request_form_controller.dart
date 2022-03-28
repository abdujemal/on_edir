import 'package:get/get.dart';

class PaymentRequestFormController extends GetxController {
  RxBool isLoading = false.obs;

  setIsLoading(bool val) {
    isLoading.value = val;
  }
}
