import 'package:get/get.dart';
import '../BL/DatabaseController.dart';
import '../BL/appbarController.dart';
import '../BL/drawerController.dart';
import '../BL/trashController.dart';

class MainBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(AppBarController());
    Get.lazyPut(()=>DatabaseController());
    Get.lazyPut(()=>MyDrawerController(),fenix: true);
  }
}

class MyTrashBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(TrashController());
  }
}
