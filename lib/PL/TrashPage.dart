import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../DL/SqlDb.dart';
import '../DL/sqlCommand.dart';
import 'NoteContainer.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  List storeData = [];
  ConstantSql sqlQuery = ConstantSql();
  SqlDb sqlDataBase = SqlDb();
  bool isloading = true;

  Future readData() async {
    List<Map<String, dynamic>> dataResponse = await sqlDataBase.readData(sqlQuery.selectAllTrash());
    storeData.addAll(dataResponse);
    print("storeData= $storeData");
    isloading = false;
    if (mounted) {
      setState(() {
        print("setstate of read data from trash is called");
      });
    }
  }

  @override
  void initState() {
    print("initstate is called");
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      drawer:const Drawer(
        child: Text("trash")
      ),

      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.redAccent,
            statusBarBrightness: Brightness.light),
        backgroundColor: Colors.redAccent,
        actions: const [
          Text("trash"),
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification? overScroll){
            overScroll!.disallowIndicator();
            return true;
          },
          child: bodyContainer(size)
      ),

    );
  }
  Container bodyContainer(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: storeData.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> notesData = storeData[index];
              print("the storeData index ===========${storeData[index]}");
              print("the num ===========${notesData['note']}");
              return InkWell(
                onTap: () {
                  Get.off(NoteContainer.Details(
                      notesData['id'], "${notesData['note']}",
                      "${notesData['title']}"));
                },

                // onLongPress: () {
                //   showDialog(
                //       context: context,
                //       builder: (BuildContext) {
                //         return AlertDialog(
                //           title: const Center(
                //             child: Text(
                //               "Delete This Note ?",
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.redAccent,
                //               ),
                //             ),
                //           ),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Get.back();
                //                 // Navigator.of(context).pop();
                //               },
                //               child: const Text(
                //                 "Cancel",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.redAccent,
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(width: 10),
                //             TextButton(
                //               onPressed: () async {
                //                 // await deleteNoteAndMoveToTrash(sqlDataBase,notesData['id']);
                //
                //                 // dynamic deletres = await sqlDataBase.deletData(
                //                 //     sqlQuery.deletData(notesData['id']));
                //                 setState(() {
                //                   // _refreshData();
                //                   print("***********setstate after delet **********");
                //                   Get.snackbar("", "Note Delete Successful");
                //                   Get.back();
                //                   // Navigator.of(context).pop();
                //                 });
                //               },
                //               child: const Text(
                //                 "ok",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.redAccent,
                //                 ),
                //               ),
                //             ),
                //            ],
                //          );
                //        });
                // },
                child: Card(
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Text("${notesData['title']}",style: const TextStyle(fontWeight: FontWeight.w800,),),
                        Text(
                          ("${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ').length <= 30
                              ? "${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ')
                              : "${notesData['note']}".replaceAll(RegExp(r'\s*\n\s*|\s+'), ' ').substring(0, 30)),
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
      ),
    );
  }
}
