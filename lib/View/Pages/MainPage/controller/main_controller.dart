import 'package:get/get.dart';
import 'package:on_edir/Model/my_info.dart';

class MainController extends GetxController{
  
  Rx<MyInfo> myInfo = MyInfo("", "", "", "", "", "", "", "", "",).obs;

  
  void setMyInfo(MyInfo val) {
    myInfo.value = val;
  }

}