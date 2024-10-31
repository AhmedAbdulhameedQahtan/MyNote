import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/resources/appSize.dart';
import '../controllers/FavoriteController.dart';
import '../widgetFolder/appbar.dart';
import '../widgetFolder/drawer.dart';
import 'AddNotePage.dart';
class FavoritePage extends StatelessWidget {
   FavoritePage({super.key});


   @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawerWidget(size),

      appBar: appBarWidget(size,'FavoritePage'),

      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overScroll) {
          overScroll!.disallowIndicator();
          return true;
        },
        child: Container(
          width: size.width,
          height: size.height,
          padding:const EdgeInsets.all(AppSize.padding5),
          child: GetBuilder<FavoriteController>(
              builder:(favoriteController)=>ListView.builder(
                shrinkWrap: true,
                itemCount: favoriteController.storeData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(AddNotePage.Details(favoriteController.storeData[index]['id'],
                          "${favoriteController.storeData[index]['note']}", "${favoriteController.storeData[index]['title']}"));
                    },
                    child: Card(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${favoriteController.storeData[index]['title']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              ("${favoriteController.storeData[index]['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ').length <= 30
                                  ? "${favoriteController.storeData[index]['note']}"
                                  .replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                                  : "${favoriteController.storeData[index]['note']}"
                                  .replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                                  .substring(0, 30)),
                            )
                            // \s*\n\s*: Matches any whitespace characters followed by a newline character and then followed by more whitespace characters.
                            // This matches and removes empty lines while considering any leading/trailing whitespace.
                            // |: OR operator.
                            // \s+: Matches one or more whitespace characters occurring in the middle of lines.
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ),
        ),
        ),

    );
  }
}
