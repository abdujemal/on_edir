import 'package:get/get.dart';

class LSController extends GetxController {
  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;

  setIsLogin(bool val) {
    isLogin.value = val;
  }

  setIsLoading(bool val) {
    isLoading.value = val;
  }
}
