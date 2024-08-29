import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mynote/BL/appbarController.dart';
import '../BL/DatabaseController.dart';
import '../BL/trashController.dart';
import '../PL/NoteContainer.dart';

AppBar appBarWidget(Size size, String pageName) {
  final TextEditingController searchController = TextEditingController();

  return AppBar(

    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.redAccent,
        statusBarBrightness: Brightness.light),
    backgroundColor: Colors.redAccent,
    iconTheme:const IconThemeData(
      color: Colors.white,
    ),
    actions: [
      GetBuilder<AppBarController>(
        init: AppBarController(),
        builder: pageName == 'NotePage'
            ? (controller) =>
            Visibility(
              visible: controller.isvisibal,
              child: Container(
                width: size.width / 1.8,
                child: GetBuilder<DatabaseController>(
                  builder: (controller) =>
                      TextFormField(
                        controller: searchController,
                        onChanged: (str) async {
                          str != searchController.text.toString();
                          print("object===================$str");
                          controller.searchRefresh(str);
                        },
                        autofocus: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                ),
              ),
            )
            : (controller) =>
            Visibility(
              visible: controller.trashIsvisibal,
              child: Container(
                width: size.width / 1.8,
                child: GetBuilder<TrashController>(
                  builder: (controller) =>
                      TextFormField(
                        controller: searchController,
                        onChanged: (str) async {
                          str != searchController.text.toString();
                          print("object===================$str");
                          controller.searchDeletedRefresh(str);
                        },
                        autofocus: true,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                ),
              ),
            ),
      ),
      // Text("app_title".tr(context)),
      if(pageName=='TrashPage')
      GetBuilder<AppBarController>(
        builder: (controller) => Visibility(
              visible: !controller.trashIsvisibal,
              child: Text("سلة المحذوفات"),
            )

      ),


      GetBuilder<AppBarController>(
        builder: pageName == 'NotePage' ?
            (controller) =>
            IconButton(
                onPressed: () {
                  controller.isVisibalState();
                  if (!controller.isvisibal) {
                    searchController.clear();
                    print(
                        "***************************888888888888888888888888888888888888888++++++++++++");
                    // HomeControllerObject.refreshData();
                  }
                },
                highlightColor: Colors.redAccent,
                splashColor: Colors.redAccent,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                )) :
            (controller) =>
            IconButton(
                onPressed: () {
                  controller.trashIsVisibalState();
                  if (!controller.trashIsvisibal) {
                    searchController.clear();
                    print(
                        "***************************888888888888888888888888888888888888888++++++++++++");
                    // HomeControllerObject.refreshData();
                  }
                },
                highlightColor: Colors.redAccent,
                splashColor: Colors.redAccent,
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                )),
      ),


      if(pageName!='TrashPage')
      IconButton(
          onPressed: () {
            Get.to(NoteContainer());
          },
          highlightColor: Colors.redAccent,
          splashColor: Colors.redAccent,
          icon: const Icon(
            Icons.add_circle,
            color: Colors.white,
            size: 30,
          )),

      const SizedBox(
        width: 15,
      ),
    ],
  );
}
