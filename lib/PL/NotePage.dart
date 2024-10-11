import 'package:flutter/material.dart';
import 'package:mynote/PL/NoteContainer.dart';
import '../BL/DatabaseController.dart';
import 'package:get/get.dart';
import '../widgetFolder/appbar.dart';
import '../widgetFolder/drawer.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // DatabaseController DatabaseControllerObject =Get.put(DatabaseController());

  @override
  void initState() {
    print("initstate is called");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawerWidget(size),

      appBar: appBarWidget(size,'NotePage'),

      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overScroll) {
           // overScroll!.disallowIndicator();
          return true;
        },
        child: GetBuilder<DatabaseController>(
          // init: DatabaseController(),
          builder: (controller) => Container(
            width: size.width,
            height: size.height,
            child: ListView.builder(
              shrinkWrap: true,
               // physics:  NeverScrollableScrollPhysics(),
              itemCount: controller.storeData.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> notesData = controller.storeData[index];
                // print("the storeData index ===========${controller.storeData[index]}");
                return InkWell(
                  onTap: () {
                    // عاد مش جاهز
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
                                "هل تريد حذف هذة المفكرة؟",
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
                                  // Navigator.of(context).pop();
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
                                  await controller.deleteNoteAndMoveToTrash(
                                      controller.sqlDataBase, notesData['id']);

                                  // setState(() {
                                  controller.refreshData();
                                  print(
                                      "***********controller after mynote delet **********");
                                  Get.snackbar("تم حذف المفكرة بنجاح", "");
                                  // Get.back();
                                  Navigator.of(context).pop();
                                  // });
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
                                ? "${notesData['note']}"
                                    .replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                                : "${notesData['note']}"
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
