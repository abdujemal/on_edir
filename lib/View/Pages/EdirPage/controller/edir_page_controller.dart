import 'package:get/get.dart';

class EdirPAgeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void setSelectedIndex(int val) {
    selectedIndex.value = val;
  }
}
