import 'package:get/get.dart';
import 'package:on_edir/Model/my_info.dart';

class EdirPAgeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void setSelectedIndex(int val) {
    selectedIndex.value = val;
  }

}
