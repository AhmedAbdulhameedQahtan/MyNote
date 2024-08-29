import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mynote/BL/appbarController.dart';
import 'package:mynote/widgetFolder/appbar.dart';
import 'package:mynote/widgetFolder/drawer.dart';
import '../BL/DatabaseController.dart';
import '../BL/trashController.dart';
import 'NoteContainer.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  DatabaseController DatabaseControllerObject = Get.put(DatabaseController());
  TrashController TrashControllerObject = Get.put(TrashController());
  AppBarController AppBarControllerObject = Get.put(AppBarController());

  @override
  void initState() {
    print("initstate trash is called");
    super.initState();
  }

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
      child: GetBuilder<TrashController>(
          init: TrashController(),
          builder: (controller) => ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.storedeletedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> notesData =
                          controller.storedeletedData[index];
                      print(
                          "the storeData index ===========${controller.storedeletedData[index]}");
                      print("the num ===========${notesData['note']}");
                      return InkWell(
                        onTap: () {
                          Get.to(NoteContainer.Details(notesData['id'],
                              "${notesData['note']}", "${notesData['title']}"));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text(
                                      "الحذف من سلة المحذوفات",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "تراجع",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () async {
                                        dynamic deletres =
                                            await DatabaseControllerObject
                                                .sqlDataBase
                                                .deletData(
                                                    DatabaseControllerObject
                                                        .sqlQuery
                                                        .deletTrashData(
                                                            notesData['id']));
                                        setState(() {
                                          Get.snackbar(
                                              "تم حذف المفكرة بنجاح", "");
                                          TrashControllerObject
                                              .refreshDeletedData();
                                          print(
                                              "***********setstate after trash delet **********");
                                          // Get.back();

                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: const Text(
                                        "موافق",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
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
                                Text(
                                  "${notesData['title']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  ("${notesData['note']}"
                                              .replaceAll(
                                                  RegExp(r'\s*\n\s*|\s+'), ' ')
                                              .length <=
                                          30
                                      ? "${notesData['note']}".replaceAll(
                                          RegExp(r'\s*\n\s*|\s+'), ' ')
                                      : "${notesData['note']}"
                                          .replaceAll(
                                              RegExp(r'\s*\n\s*|\s+'), ' ')
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
                ],
              )),
    );
  }
}
