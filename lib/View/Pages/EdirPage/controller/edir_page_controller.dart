import 'package:get/get.dart';
import 'package:on_edir/Model/edir.dart';
import 'package:on_edir/Model/my_info.dart';

class EdirPAgeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  Rx<Edir> currentEdir = Edir("", "", "", "", "", "", "", "", "", "").obs;

  void setCurrentEdir(Edir val) {
    currentEdir.value = val;
  }

  void setSelectedIndex(int val) {
    selectedIndex.value = val;
  }
}
