import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mynote/controllers/notePageController.dart';
import 'package:mynote/resources/appSize.dart';
import '../controllers/FavoriteController.dart';
import '../controllers/appbarController.dart';
import '../controllers/trashController.dart';
import '../resources/appColors.dart';
import '../view/AddNotePage.dart';

AppBar appBarWidget(Size size, String pageName) {
  final TextEditingController searchController = TextEditingController();

  final AppBarController APcontroller = Get.find();

  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarBrightness: Brightness.light),
    backgroundColor: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
    actions: [
      Obx(() {
        return APcontroller.isVisible.value
            ? Visibility(
                visible: APcontroller.isVisible.value,
                child: SizedBox(
                  width: size.width * AppSize.size226,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (str) async {
                      str != searchController.text.toString();
                      switch (pageName) {
                        case 'NotePage':
                          Get.find<NotePageController>().searchRefresh(str);
                        case 'TrashPage':
                          Get.find<TrashController>().searchDeletedRefresh(str);
                        case 'FavoritePage':
                          Get.find<FavoriteController>()
                              .searchFavoriteRefresh(str);
                      }
                    },
                    autofocus: true,
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.white)),
                    ),
                  ),
                ),
              ) //search text form
            : Visibility(
                visible: !APcontroller.isVisible.value,
                child: switch (pageName) {
                  'NotePage' => Text(
                      "المفكرات",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  'TrashPage' => Text(
                      " المحذوفات",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  'FavoritePage' => Text(
                      "المفضلات",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  // TODO: Handle this case.
                  String() => throw UnimplementedError(),
                }); // page title
      }),

      const SizedBox(
        width: AppSize.size15,
      ),

      //Search Icon
      IconButton(
        onPressed: () {
          APcontroller.toggleVisibility();
          if (!APcontroller.isVisible.value) {
            searchController.clear();
          }
        },
        icon: Icon(
          Icons.search,
          color: AppColors.white,
          size: AppSize.size30,
        ),
        highlightColor: AppColors.primaryColor,
        splashColor: AppColors.primaryColor,
      ),

      if (pageName != 'TrashPage')
        //add note icon
        IconButton(
            onPressed: () {
              Get.to(() => AddNotePage());
            },
            highlightColor: AppColors.primaryColor,
            splashColor: AppColors.primaryColor,
            icon: Icon(
              Icons.add_circle,
              color: AppColors.white,
              size:  AppSize.size30,
            )),

      const SizedBox(
        width:AppSize.size15,
      ),
    ],
  );
}
