import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote/controllers/notePageController.dart';
import 'package:mynote/resources/appColors.dart';
import 'package:mynote/resources/appSize.dart';
import '../widgetFolder/appbar.dart';
import '../widgetFolder/drawer.dart';
import 'AddNotePage.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  NotePageController notePageController = Get.find();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: drawerWidget(size),
      appBar: appBarWidget(size, 'NotePage'),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overScroll) {
          overScroll!.disallowIndicator();
          return true;
        },
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(AppSize.padding5),
          child:Obx(()=>ListView.builder(
            shrinkWrap: true,
            itemCount: notePageController.storeData.length,
            itemBuilder: (context, index) {

              return InkWell(
                onTap: () {
                  Get.to(AddNotePage.Details(
                      notePageController.storeData[index]['id'],
                      "${notePageController.storeData[index]['note']}",
                      "${notePageController.storeData[index]['title']}"));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              "هل تريد حذف هذة المفكرة؟",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "تراجع",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () async {
                                await notePageController
                                    .deleteNoteAndMoveToTrash(
                                    notePageController.sqlDataBase,
                                    notePageController.storeData[index]
                                    ['id']);

                                notePageController.refreshData();
                                Get.snackbar("تم حذف المفكرة بنجاح", "");
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "موافق",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Card(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () async {
                        notePageController.favNoteState(notePageController.storeData[index]['id']);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: notePageController.storeData[index]['is_favorite'] == 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // title of note
                        Text(
                          "${notePageController.storeData[index]['title']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        // body of note
                        Text(
                          ("${notePageController.storeData[index]['note']}"
                              .replaceAll(
                              RegExp(r'\s*\n\s*|\s+'), ' ')
                              .length <=
                              30
                              ? "${notePageController.storeData[index]['note']}"
                              .replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                              : "${notePageController.storeData[index]['note']}"
                              .replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
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
          ),),
        ),
      ),
    );
  }
}
