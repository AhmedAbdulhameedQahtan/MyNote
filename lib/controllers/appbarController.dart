import 'package:get/state_manager.dart';

class AppBarController extends GetxController{
   RxBool isVisible = false.obs;


   @override
  void onInit() {
    super.onInit();
  }


  /// تغيير حالة الرؤية عند الضغط على الأيقونة
    toggleVisibility() {
    print("isVisible=========================$isVisible");
    isVisible.value = !isVisible.value;
    print("isVisible=========================$isVisible");

    // update(); // تحديث GetBuilder لإعادة بناء الواجهة
  }

  /// إخفاء الحقل عند فقدان التركيز (إغلاق لوحة المفاتيح)
  // void hideFieldOnKeyboardClose(bool hasFocus) {
  //   if (!hasFocus && isVisible) {
  //     isVisible = false;
  //     update(); // تحديث GetBuilder
  //   }
  // }

}