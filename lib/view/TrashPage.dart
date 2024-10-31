import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/resources/appColors.dart';
import 'package:mynote/resources/appSize.dart';
import 'package:mynote/widgetFolder/appbar.dart';
import 'package:mynote/widgetFolder/drawer.dart';
import '../controllers/trashController.dart';
import 'AddNotePage.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  // final TrashController trashController = Get.find<TrashController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: drawerWidget(size),

      appBar: appBarWidget(size, 'TrashPage'),

      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification? overScroll) {
             overScroll!.disallowIndicator();
            return true;
          },
          child: bodyContainer(size)),
    );
  }

  Container bodyContainer(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      padding:const EdgeInsets.all(AppSize.padding5),

      child: GetBuilder<TrashController>(
          builder:(trashController)=>ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trashController.storeDeletedData.length,
                itemBuilder: (BuildContext context, int index) {
                  // final Map<String, dynamic> notesData = trashController.storeDeletedData[index];

                  return InkWell(
                    onTap: () {
                      Get.to(AddNotePage.Details(trashController.storeDeletedData[index]['id'],
                          "${trashController.storeDeletedData[index]['note']}", "${trashController.storeDeletedData[index]['title']}"));
                    },

                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext) {
                            return AlertDialog(
                              title:  Center(
                                child: Text(
                                  "الحذف من سلة المحذوفات",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:AppColors.primaryColor ,
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child:  Text(
                                    "تراجع",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () async {
                                    dynamic deletres =
                                    await trashController.sqlDataBase.deletData(
                                        trashController.sqlQuery.deletTrashData(trashController.storeDeletedData[index]['id']));
                                    Get.snackbar("تم حذف المفكرة بنجاح", "");

                                    trashController.refreshDeletedData();
                                  },
                                  child:  Text(
                                    "موافق",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },

                    child: Card(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //title of note
                            Text(
                              "${trashController.storeDeletedData[index]['title']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            //body of note
                            Text(
                              ("${trashController.storeDeletedData[index]['note']}"
                                  .replaceAll(
                                  RegExp(r'\s*\n\s*|\s+'), ' ')
                                  .length <=
                                  30
                                  ? "${trashController.storeDeletedData[index]['note']}".replaceAll(
                                  RegExp(r'\s*\n\s*|\s+'), ' ')
                                  : "${trashController.storeDeletedData[index]['note']}"
                                  .replaceAll(
                                  RegExp(r'\s*\n\s*|\s+'), ' ')
                                  .substring(0, 30)),
                            ),
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
            ],
          ),
      ),
    );
  }
}
