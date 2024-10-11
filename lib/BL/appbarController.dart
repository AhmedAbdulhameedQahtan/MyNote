import 'package:get/state_manager.dart';

class AppBarController extends GetxController{
  bool isvisibal =false;
  bool trashIsvisibal =false;

  @override
  void onInit() {
    super.onInit();
  }

  void isVisibalState(){
    isvisibal=!isvisibal;
    print("isvisibal*****************************${isvisibal}");
    update();
  }

  void trashIsVisibalState(){
    trashIsvisibal=!trashIsvisibal;
    print("trashIsvisibal*****************************${trashIsvisibal}");
    update();
  }


}