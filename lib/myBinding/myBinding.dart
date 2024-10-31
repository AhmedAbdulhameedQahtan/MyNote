import 'package:get/get.dart';
import 'package:mynote/controllers/notePageController.dart';
import '../controllers/FavoriteController.dart';
import '../controllers/appbarController.dart';
import '../controllers/drawerController.dart';
import '../controllers/trashController.dart';


class MainBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(NotePageController());
    Get.put(AppBarController());
    Get.lazyPut(()=>MyDrawerController(),fenix: true);
  }

}

class AppBarBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(AppBarController());
  }

}

class MyTrashBinding implements Bindings{
  @override
  void dependencies() {
     Get.put(TrashController());
  }
}

class MyFavoriteBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}
